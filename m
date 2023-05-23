Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4935F70E09E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236942AbjEWPfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbjEWPfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:35:04 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC55C129;
        Tue, 23 May 2023 08:34:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QiYVJNfcFSsQltB4t+xNcfA8Mn58s3f5djFpqgsdrAaAjdwzxy2yRr4K2wvsbPBj/Qzx7EahRSH/Om3v57LUICkIWmtlCjMWPw7KS2krVir8S/wXFKwI3dhZrDIDzMOT5mTBKFLs9KiYtaXAmcCjQGu3/HLk8zHPxdX+MJeug9mMlyGJQ6TZ5OwqgHwt4RRdaj5tDhecU23iXBiKLM1PBYXu+1dstygTTj1XlRNXpttVbpj1Dt8fkrN5UzQQuecu3PVOWd7rmBkgEMmQMzsfMpa5s5ziVObKnxscjcOCqjttA681QyssuF3d8eDZ7Qd8QwcK7CIhHTUWP2jvIdsMew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPDhgCFxJO6nyaeCoS732w2jD4lERozM7qbnAJUUrng=;
 b=kgzXqp7Hb3TY9MrmUKOr3cg+iXVJidtddJzq9zdzBbhPk07FwXvaWPStVgNB4wv7PENc7PoV2a8yExTAMM9fxWtNWa3GlClPi1FvwCtAfoTpy8yofjj4PjEZKGI58fPxQ876NF5q4Pd4GD2rkhdkT4CZJIvoBP4+6l8H/xAaviIaB2ba8A4v3fsc5hUg9WnfGJUYza7UJG6WpTeuk3/WKT7h1M/KGyxynZt4MdAit++s7yWY8w4HPbbokUCAW2LDLAJWejLuxU+bsp070KIqia2ldgFtRknvsQcDsQjzoCUV9NDuOjkXjY31Q6lJYA0BFkQsOsP1A1297c9joPYZlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPDhgCFxJO6nyaeCoS732w2jD4lERozM7qbnAJUUrng=;
 b=jW2UtICS8Fw1+sxtA9zgYpglwASmDklkC+JOrOIKALijt3n986hcVQvjNb637Np6nFrdVa9kRRTtnbFSMBQpGzEKa68TuPX25sVNWqij5mDLGZj9PvOalVZHhX4wL3T97Ea4B6+AegLuPcNh0JvoxcHN04656W6eEn0PnljPjz8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9571.eurprd04.prod.outlook.com (2603:10a6:102:24e::7)
 by AS8PR04MB7544.eurprd04.prod.outlook.com (2603:10a6:20b:23f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Tue, 23 May
 2023 15:34:53 +0000
Received: from PAXPR04MB9571.eurprd04.prod.outlook.com
 ([fe80::b082:c033:f721:d448]) by PAXPR04MB9571.eurprd04.prod.outlook.com
 ([fe80::b082:c033:f721:d448%7]) with mapi id 15.20.6411.029; Tue, 23 May 2023
 15:34:53 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, iuliana.prodan@nxp.com
Cc:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH 0/5] Remove CRYPTO_ALG_ALLOCATES_MEMORY flag
Date:   Tue, 23 May 2023 17:34:16 +0200
Message-Id: <20230523153421.1528359-1-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR07CA0020.eurprd07.prod.outlook.com
 (2603:10a6:205:1::33) To DU0PR04MB9561.eurprd04.prod.outlook.com
 (2603:10a6:10:312::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9571:EE_|AS8PR04MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cd2e787-e560-407c-114a-08db5ba34094
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a5ca9UH/pIw53910Q/UNNJrG8abLT4o4LFVYRduFsrwDW9NZM7/SiAXRJDoXq2Q/N43w+zAyhQLcRFHcHROcMj9eVBGAxX3W4hRkINKfIIRz7BgPhMjz+FG5lh/zwD9djBS9NQ/kz8uCkLA4uH7vAycxmOVlT01qh7ZnlFWQwI4HJr40U8q73ZFLtSGtaIt+7Nw/a6kfkYlRdb61gfuJ4eog8YPPeVDN/NkUA/W3UlAkq4G89oRujb9VqaqBxddvuz3fYRVyOsCNMD16cQxK3jEyBIImzMd1yKm3CRtVMwtRSKCjyUUBFEOPA6ibvGA4V1OXMJtVzgx0JndAeIYyGBnVRgl7E6ccQ+JMnGwt4I2a95JtxQAYexKPp8NZrEj4nqAPJHjIwljdeU1XSaB6zjqDIEb9Yf9Ty/8D7EFkeb3CmphmHQNabLfU7yqc6MctAuHGQH7nA2hjt1b2G/nCJOHFlDzVzznllotTLl8gbgnGnmJaZmtgJTIFiYOcmNWMq0g1kXPC8DiTrSHlQGicbJ2LGy0FrVXJlAmpLFDBl9T0KABjGdTUvfOIAXVhGm+IiguYUmrHZY2MUkcorbpiBM6UE4MFbkcfA72lOFqSsVKHnifJyAMQlcdJMjmmbKIu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9571.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199021)(38350700002)(38100700002)(36756003)(86362001)(9686003)(6512007)(6506007)(8676002)(1076003)(8936002)(2616005)(2906002)(186003)(478600001)(4326008)(316002)(5660300002)(26005)(41300700001)(6666004)(66476007)(6486002)(52116002)(66556008)(66946007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xH+5ZfVA4A3ngLDn5yH4If25az4D0A4vOtzprROtXqbP5Gw5NdSjgPT+5o8A?=
 =?us-ascii?Q?BLdwEdKvspnmbq/nDQkpBD8ffOXh4TKz7JOfAgoEBwrEhmSKR5b6hx6xMNkQ?=
 =?us-ascii?Q?pgvdUORRzdv/AQDAX9Zl23JU0zYj7WcbOV4Ju3v4y+mkp2TMz7GPyS67WCyf?=
 =?us-ascii?Q?NRGMQLTFxsEl8XcGRXEeN/+WkBtHU7IsPyh6i5TarAxwCTNuCtdElnCnw1c2?=
 =?us-ascii?Q?KmXplBcMB0r/B7dY1m9klN3Euh61pOJYhNb1vdKW1LLrmy0FJpwc6E4zydX+?=
 =?us-ascii?Q?960R3jXLVsjJ3UGosQ36ATcS54DSCNDwc1qlgfAES1u6KR1oVlr/oUkKYpxj?=
 =?us-ascii?Q?hbVXmc/OHup/zrdxwmw0wD4+y/YhTzDsc3UvV2VDSkyFhWS3KtTMkrOR/M53?=
 =?us-ascii?Q?DysoN0IIBXxdOtETdnfuX3rG9T7kWccm1E1h7o02VdebKL9ymjrhlpN89lLy?=
 =?us-ascii?Q?uCfTuBr+X/muRHVchIpyR3BakHB7Xy0qO3diXdSG/l0d2tHPe7jI0m3SHZQY?=
 =?us-ascii?Q?FJkMbUxVCeuinwiyZ0VkHDgPgGwK5Pyyq/lUqSUGZYwj39vFSMI8Tt8Yy1Q3?=
 =?us-ascii?Q?wmSTpDIxVjXZDVAiVJufFr040EU2MyjbLi7ZUjtIbcdgZNwqrzs7ciUUNwUW?=
 =?us-ascii?Q?f28KhupbjF3XiHBI5Ptgys6bavkNAxhQOimsEvjE7EredJ0k0JgBmf76Rq5Y?=
 =?us-ascii?Q?VOl0YBbxy84VfXMAWvTo1qfoEJFk4Wyzh8UonfhChYdD4PAbi0UVqAjXsPw2?=
 =?us-ascii?Q?siLPrR07YaQfO+2wJv6UdDxNClwYUOdUxuzQtoOqAaol+ovnD6HVoSDvJCIh?=
 =?us-ascii?Q?nr8XoVh9hcIA1UqwSZXpRb3hX+l6VDSQNB6c5RjRpzp+oEsNnVInWheW18hB?=
 =?us-ascii?Q?9VBXVBVvvurieE8h/q+GcoHEPn2bdYCFYouOM9x+E9a2OkxHaaPkHETTLlhd?=
 =?us-ascii?Q?JSF7GOSB2RC1Cytf8m8fyWgMkpryrWSldNGXAe3Twuc7jm7OOj4pOAgdWdw5?=
 =?us-ascii?Q?CUU2uNetEDVbwTPZqYSumQClI6JqLLEg2eykKuC27NMg0qyz/yeEsN7xFq5o?=
 =?us-ascii?Q?Tifiqt9K9mebOHzsuzhCr39LlMCzBFl+roSDVwo9+FYIf6/TGXLMAQIpkivK?=
 =?us-ascii?Q?uT94b4GSVRe//pUqSxRLIzj6fcg4TUKeJnQ+bGlroFoYRtiCF/Gmti+WpP7E?=
 =?us-ascii?Q?5aDlX+yi45uw7zTiEyN5Y8oPuWzN46uwMJux+EWpQeAwM+tl4netKjvEs4DE?=
 =?us-ascii?Q?n8edHEZHP8tQbb5DqFb9alKbJAaBYLSpxUuaZbN05Iv00ozwfu73/eJMl5Gq?=
 =?us-ascii?Q?unE3pcq9XMf1MszbbgU/YTPyeYSdP6oAvErUSNUjUoDuuE3tMh+8B2n8rTIx?=
 =?us-ascii?Q?Ytf+icNcWNvUOq1je69XUT87sqO7xw/IEAsqIkz7YxCkaOh7BEuBwp+Q3CJX?=
 =?us-ascii?Q?Bp77yXnXbRASwo6VXiuWDqLmEyzPT59c7++CgHBVBrfyGdyB9u4hs4YAWu3c?=
 =?us-ascii?Q?9W6k0xfXXEJ8ajs/wdspLmDgA6qy2D81nf7jbckuaIubef27TH0h5CLfHiMv?=
 =?us-ascii?Q?5YXu46BzO1CDth/dmaR3ZXTfgPBnYcPMUJFXxwfoZEGiiREy3uGWSNpfX8fy?=
 =?us-ascii?Q?dw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd2e787-e560-407c-114a-08db5ba34094
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9561.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 15:34:53.2111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9S5GMnMLv9b+2yhF2SmbMXOpgbjS8RD7pImzHzfrypVbmR1vB0E8XHEVHQWHoqJ8pX964R9dZWmtM6pPyCJx8DWtXsLomVq/cswZznPtkKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7544
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>

This series includes patches to remove CRYPTO_ALG_ALLOCATES_MEMORY flag
and allocate the required memory within the crypto request object.

CRYPTO_ALG_ALLOCATES_MEMORY flag is limited only to dm-crypt use-cases,
which seems to be 4 entries maximum.
Therefore in reqsize we allocate memory for maximum 4 entries
for src and 1 for IV, and the same for dst, both aligned.
If the driver needs more than the 4 entries maximum, the memory
is dynamically allocated, at runtime.

Meenakshi Aggarwal (5):
  crypto:caam - avoid allocating memory at crypto request runtime for
    skcipher
  crypto:caam - avoid allocating memory at crypto request runtime for
    aead
  crypto: caam - avoid allocating memory at crypto request runtime for
    hash
  crypto: caam/qi - avoid allocating memory at crypto request runtime
  crypto: caam/qi2 - avoid allocating memory at crypto request runtime

 drivers/crypto/caam/caamalg.c     | 138 +++++++---
 drivers/crypto/caam/caamalg_qi.c  | 131 +++++++---
 drivers/crypto/caam/caamalg_qi2.c | 421 ++++++++++++++++++++----------
 drivers/crypto/caam/caamalg_qi2.h |   6 +
 drivers/crypto/caam/caamhash.c    |  77 ++++--
 5 files changed, 542 insertions(+), 231 deletions(-)

-- 
2.25.1

