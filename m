Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BAC744303
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 21:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjF3T6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 15:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjF3T6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 15:58:14 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C8F1BF3;
        Fri, 30 Jun 2023 12:58:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rq8qiPHsF8+K6WxYckrS6xZDDnZt9Q2F4FotZ5LcNyuw8CRAqeb5CnvZjx6mEgqwpmJAlkn+ZvH0O3Fo3n7QQQ1tS1BfekdVqw2UyuNC+k7hBe6HJTBah3In2wDqiHOPx2/g8OHlMzjmYRlSHXspaLww9VIGNy8V/iwmiTD8xhBxNrZk1jybWhkvDTDvfc1fI7FsB5Bkmfv275m/DPP1u55YGl0Q7eWwvzq4hHcf1qymo/fMPwOu+JczWPwWJjD6Ao7Xpi1l49fT909wjebSQes4Vyi7zEXUfwCGLYcsIOIEhTa0KHtGJkPP+NCQUqpJVAkn44D6nzdSqeMiZAZ2Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWs1B3BJTtkd+RaOM5ujZ/ixKrcDnRJDxFcgZ9Ws+NQ=;
 b=F3P/KumcwZvkcGuX7zpinOb6t5aXZdAZBoe9xAYIt7A33+P2RHcSikemPlgWoGsnnADJPjyGmu76E0i0HeSmEVqUb8nt3nlpKWtwfU/E9WTksjW5scnLaOxj92G1gb2xYmdmbGB0oZxWYXnfmI6vAHrrDXfXaSZa8MM6FRYh/PiBAcQC6cIfCM40eANtByR4cCCSTQi5/XcGeDFe6nfs15U8F0KT/H4lEjhKL5Iq/VeinKwbKzHgOm+X6E3PN4AyL6ng60lSBK4yno5IEYGHAkSSRPY+MTMjyaLcCN+xaH/0KO3VYhcSJF7AXps6cbchjhD6jbuZt8fU/bmSrGTVvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWs1B3BJTtkd+RaOM5ujZ/ixKrcDnRJDxFcgZ9Ws+NQ=;
 b=ccsqmX7UOEMVs+7L5DqsAsmQDVywvfd3YZEn52Ve4R/qQ2I8ws/WF85VpkpC591Cggrwo8/ldD4Qsi57Gr2skCf8F6LiNp+0dQSjC2uqP9pmW2/YnkLf/DnwdQsRwGZSlZw0vyxYHLcEjcvJVivio8UEFuimOsiTGiyNo1VzJR4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBBPR04MB7947.eurprd04.prod.outlook.com (2603:10a6:10:1f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 30 Jun
 2023 19:58:10 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 19:58:09 +0000
Date:   Fri, 30 Jun 2023 15:57:54 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     "r-gunasekaran@ti.com" <r-gunasekaran@ti.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        Jun Li <jun.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Elson Roy Serrao <quic_eserrao@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?iso-8859-1?Q?J=F3_=C1gila?= Bitsch <jgilab@gmail.com>,
        Prashanth K <quic_prashk@quicinc.com>,
        Peter Chen <peter.chen@kernel.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH 1/1] usb: gadget: call
 usb_gadget_check_config() to verify UDC capability
Message-ID: <ZJ8zwiTHKIaH5pFB@lizhi-Precision-Tower-5810>
References: <20230628222437.3188441-1-Frank.Li@nxp.com>
 <42940cae-ce4f-577a-474b-f06b3b481e4e@kernel.org>
 <AM6PR04MB4838E7A9B41AB382DAAA35038825A@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <158f9975-afff-25b8-130c-2a8381ce21ee@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158f9975-afff-25b8-130c-2a8381ce21ee@kernel.org>
X-ClientProxiedBy: SJ0PR13CA0236.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::31) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DBBPR04MB7947:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b1eef0-4712-455c-5cfc-08db79a45403
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C07FrfygejP6pfeMKuC+M6iXnEMtFPkZjUMW8434O9rXkNw4L5cASD1MR4MZhZ3sDOnGICvj61khVbK8RbxOcAGVwc9ThT6MHEY46MSzeI2xoDsTg640q88MjQVnKd8CXTj016+HZary3EYIyY9u97h4K7wOED/2NmuhBx2Y0UIUeyuUkFNACYfx9U9F+Aypzrg7GAwZLEd4Stje1xLzBLI1EgQgvW42bdvoadoyWRC9DT3byT6CYNPAuO9Sj39Z/V0Od9ZBqLT6BYDRMrPjtlHw4vxkMDaiPmvoRrhomxVybbNhY3fdGydr68TaGb4goxj60ZZ8cKc7wxo+t/aGDfREQUCbNSnSGoTCWx20DM82hvR/JHOieV4G9paU85dRaIHd1SSWdNLWy1dDKnKWZbRtPhlOlbwekfMudCvNZhOzLxrzZhRcCTeYeih2OdNFNh4ZdB4VqLX616e1Y6ipxy8csjF6YDMLPpKkELUe+/mPhtnzyYT7sbM2R7Wsgq3xB0frgIxXWEJoJZAHi1kdSCs4D+fpLBC64MsjNEwzt8i/uAJhv2sMOqDaDr00qbF0wGys+fCl7s31uDzqNHRXB9z7pX5NYyQ63u+WfgV00zNZC3OAaKoBeqGGT3OUjhn80pK8JGpoO/OzCUpYFxP0uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199021)(54906003)(52116002)(6666004)(478600001)(6486002)(966005)(4744005)(66946007)(2906002)(186003)(26005)(9686003)(66476007)(6512007)(6506007)(66556008)(33716001)(41300700001)(38350700002)(38100700002)(7416002)(5660300002)(8676002)(316002)(8936002)(6916009)(4326008)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IZz21I3x80VwzLHt0ZcDqy0+7A5Yf8UrTmcjleJ17lIzGqAlobms0jYInptv?=
 =?us-ascii?Q?P1e4cI5Ql1Gg9TMO8+I6IKQ+CHEOuIhApGNP2g7Q26phwuH8cnGlH8aOwQDj?=
 =?us-ascii?Q?iYD24V3c3GKEjAn803n8+MUKecekDvYut9BR9Uuov7Dkn2b9sKYUEwUPALR7?=
 =?us-ascii?Q?7F2HF61UlzOWuGoZE8pIgYC+YSRExE7FK9UoYs30/foLuj3VPxs6ACQQRUsh?=
 =?us-ascii?Q?AR2flMJBnkTKs18kyG4ASxvH1mJpCeArVyToTSKnaZt3jKOGKIyDhTnEga9k?=
 =?us-ascii?Q?ypL1JaAqK3hsdho5Ie0jRzwK9puwka266Ecmb4ZqHcjEpq+YIeEl9VN/Frek?=
 =?us-ascii?Q?xSTk9SxT4xvvyESkxnTW3aZEuB3KrhNVQpk/h+tiBL18uz+ucOGnTDVKYvFL?=
 =?us-ascii?Q?rh6yXawDZPXgrFlhizh7a86m5xAgRDPru+LM/0PGdTMUPekAIk9Ij/DfPXke?=
 =?us-ascii?Q?gAjCsZ1iPJv/QU539WcBMzMxfCtSDXVfwF/+aCdj2iyZGi1TW//cmruE78dD?=
 =?us-ascii?Q?8hieRpsdjfJZEUzGiavI3efWBDhN+4QUwqa1Y2mnoCS4J7fSCbQskfM83cUQ?=
 =?us-ascii?Q?GqE7zvAYFgEH7XyzZEEipA6H3CmPH1Zo8A9crKou954C615DotGjK1KymC33?=
 =?us-ascii?Q?BSfmYOFv2054oQKzNgbG/uj2ZvdrMEQNcD16unCgFBZ9cvVw7FlIzzzqjOX+?=
 =?us-ascii?Q?vxiVB8Qu49e02Vn3f1v+wL/HVQIgFat6WImiJUfjAExv0jUpLA3h0U0wAkUB?=
 =?us-ascii?Q?aeTNwwZKEsxCQZJZS+cqz17mH9giP3hHNPhFYPoVExUE/ZpVnqIAwWquhvd4?=
 =?us-ascii?Q?GX5tYwuQe6IffVb5KDGeO7boMYHqe+JbLsiSOlz0RmBtlckKMTe3ONcTFkuT?=
 =?us-ascii?Q?e2dpxSK4/bY5HcZMCzIA57WnVgTLh/JkDZV5CrotqrvZi1ztXB70UdSfisuv?=
 =?us-ascii?Q?z/yoKq4/ojGcGS69/9sKGLdgROD2vhwJavfdbt51Mh4DDU3Ano9KTE47j9u/?=
 =?us-ascii?Q?2FBizg3zUW6mB9rfHZjbZ7v6OyR/cs/CyrAPUunEBwQ4ly8qKmdgLIACw0q1?=
 =?us-ascii?Q?haTbzSsnoFNQxsUzdR8lFPpJyE9O42yAAGHDW1H4eWC1oAoHTf2zD1qbHNnC?=
 =?us-ascii?Q?s2S98tVW/UqkzQoxKSONMVurull15vYMpQcVimM5e0uGaTdEbWL3zdjESwEN?=
 =?us-ascii?Q?VXWqQRmRapukLEFxcLuHZVLlyQrC7MBPIi54b55R6z9NkWrEwiZpinRJXVKL?=
 =?us-ascii?Q?W53TgwuXeQW4h9Iqu+8zgezsjG7e+EsAxXTQ7hAJDunvsAYk8E4depPivo8C?=
 =?us-ascii?Q?zlVaa9yKgGLdxDPxUR8OWDtglRlsiQpaw4vNnPvGoMr1ljDGvHC+mpdOk6EU?=
 =?us-ascii?Q?i1zfnfQZOOlyNP5ThoubyRdCn6MSyQ4xbl/6A/jM5whuk3G6Pr/X9y5nXkm/?=
 =?us-ascii?Q?K+iibwEkT7lIn5fqUC6WsfY9k66R7NdqBWJBaLmd6RGEtJlU/H1zPp1y3QbU?=
 =?us-ascii?Q?cJ/xCLGUnBvZigcOTBedar0p+twTm0D1FoCmwMap1x7u3P+IhH/BSO/RymsC?=
 =?us-ascii?Q?JQI0V9ivIivMoyNIfHE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b1eef0-4712-455c-5cfc-08db79a45403
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 19:58:09.6057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AlYgqnK0cO3N/2BD2ngTXzLNFi0D7F3zjYIZY2zKWM81ZhVxQXM8advohryyR14KZUbLodZFKJnUlY8nCJ5jaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7947
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 10:43:14PM +0300, Roger Quadros wrote:
> 
> 
> >  .check_config		= dwc3_gadget_check_config, 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/dwc3/gadget.c 
> 
> I meant gadget drivers not UDC drivers.
> 
> e.g.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/gadget/legacy/dbgp.c
> 

This is for EHCI host controller debug port, specially implement simple
tty gadget devices. Generally used for PC. This driver suppose will not
use UDC at all.


