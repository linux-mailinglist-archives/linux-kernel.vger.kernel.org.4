Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDCA7423DB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 12:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjF2KUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 06:20:02 -0400
Received: from mail-am7eur03on2053.outbound.protection.outlook.com ([40.107.105.53]:34528
        "EHLO EUR03-AM7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230487AbjF2KT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 06:19:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AR30PqmpGGKFyMJ8+Jh0AIZ5Ny0l3Q7d/u7tmh6wKuuNgQNb/Qmeb03WYJwBabWMNpVb8lFSiJXnwCtKeTZ3R3r6Ngr2qSZQL4M2adnCFPoDYZnT4pxLkEjt8eQC6nmQTrNr9mzEHWEIiYaFc9huNqBV7dVurNi4U3diaUxd4OK+Mc9mLvjbtqMNYdkeazuH1LHGFaTkHxd+zMwHoH42n3oeH6Jhx3d7/IlKEekxh+asUt+O/b4swA0Pp+uTmSA4hSUwd95pDCX8haaCtRAomRgJSbhfj0fwYqn0IH4JkstzQKnNYSvCqr265FHUEG9pUA1lPQoW6d62UOdgRTnLWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrGcGVFZRryAg+bPbtwRdLEE6nCvxkgYLSqKRBl7t/w=;
 b=ObZ75XZB/YrX1ob6u9ZfknMmg8foV7pm1b8P61D3HIYlzDsefy1xIuwenHi6abax2oksjIcUw4e4XYppvEboYAgw2eWF0rDBJHdPlBUD3LU2g2B6WJGH3D58s0Ajqv9yY+HtYiDWO5gPv0RVp90iHj2RwViBfJlk9XNeB9duSWQGhH+zbPrZ3xKmBDaLgHqXk2hEDM4GjB3SdZD6AXRHErmhYz/0S3R5Rt6T26q1IybjFVtyPEeGsJaHGVKnr8nHjn8NjhWdGcvjfNrYGaFsNi7wPi1jBXS4KeoMucG3LeLpR1qlcOTiKht+8ncErEMHq+bhySgteUfLtQ+RfjCErQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrGcGVFZRryAg+bPbtwRdLEE6nCvxkgYLSqKRBl7t/w=;
 b=WkJkpPzzdmGWPUcsQ/zpTc1ekTarEX/gc7+LsqYVamUbujiEUtkAunP00WKRvlhCKroIGFqaE1EeMUskEl/P6/xHnqab0wrmtoKPlvN/gNdw9SmYcBg6pX15B85xsJ91G7KAFxp37uHcrZFEuvwGw1ttREUyfN0ecHfzdfM04FY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Thu, 29 Jun
 2023 10:19:54 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460%5]) with mapi id 15.20.6521.036; Thu, 29 Jun 2023
 10:19:54 +0000
Date:   Thu, 29 Jun 2023 13:19:50 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net 1/2] net: dsa: sja1105: always enable the
 INCL_SRCPT option
Message-ID: <20230629101950.7s3kagwvkzlnu7ao@skbuf>
References: <20230627094207.3385231-1-vladimir.oltean@nxp.com>
 <20230627094207.3385231-2-vladimir.oltean@nxp.com>
 <f494387c8d55d9b1d5a3e88beedeeb448f2e6cc3.camel@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f494387c8d55d9b1d5a3e88beedeeb448f2e6cc3.camel@redhat.com>
X-ClientProxiedBy: FR2P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::25) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS8PR04MB8644:EE_
X-MS-Office365-Filtering-Correlation-Id: d18d7fa1-aa91-4a98-9668-08db788a61ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WWCMhGbKDefBZ6bKtS9IF6sN+uWPfnRB4dFIM5CXCWSfoqCvWHdnbN5TgPQIel7fnmwE7jGslJy9B+apoLVa6SquDF8Mw7ODt0sZE773vFwMi0EhCL8eZLAL6TV8xBHfwNoDf3xrTBxzZyh4Jcg87L9T5ngbow7EJFi1OrIvuBT11ifDgTTnRo2pNNQNStyXpunC/wfQfzTn/zeBui/4Ia6z7B2Yi6XVPKO91Fkyr2dujrjVZ0445DsvU+BlAyN89HHdwr5fU/izYknppTLep4zVZGbEu7Y/cVuAyk3Z355D8RH/DBzn/piQDMgJ3Vb7AAsfDGPZ+LYDSZaKUMDFyjtSC/C8jK5wJqEmWyfHWLyjit6UTFd7KZrRlhPOEz9zmfC1xbxVgRNEucSpXjckYRUM/DYqowJfciAHZJf64YwOJ4Ay8cZkMlNVQwKMejhrT79uSMOx3wovdQqYW+ubGZYiz6E8R8H6M7SIgHiWPKHFQYgmPILl4d5B9hRN1RT1PkoRlgi1vbAzivU/xKIvTgayuSYWKjNOkk7KWL2UDfWVHssjzCOM/80Fz1XU5mCB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199021)(6666004)(1076003)(478600001)(9686003)(6486002)(6506007)(6512007)(186003)(26005)(54906003)(86362001)(33716001)(2906002)(83380400001)(6916009)(4326008)(66946007)(66556008)(66476007)(8676002)(5660300002)(8936002)(44832011)(38100700002)(316002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MkCsxeoi4p2Jjc+YmGvYJMz/t8MKLatWD3diNknLcYi1Jnva4gZpPgrSHa+S?=
 =?us-ascii?Q?hPUeHNRaEqAbYj9ZXS9cGZzJRNvP3MXIA0gLUiTQSn1gmUNHPByiVvblGrX7?=
 =?us-ascii?Q?JxqeO0pmL2mhj8JfjpKQjVlE200dPdKFdge/bjG+i3Ngg1FKm7EgbIpKW+gK?=
 =?us-ascii?Q?Ubm95qdW82OfEdgyGKippRu4EhEd38Vl9epG9bCwxMnA6kFTOoxejwM9ym9u?=
 =?us-ascii?Q?3SP20s8QdoPCoHHFtbzIwILvFA2tzaZtYeiCjEoCOOC6YS6ceIP1lOEp8NIF?=
 =?us-ascii?Q?3ZJ5t54ogsPh7ybM41XIbQlPPgWXqmZDaS8OJsK3ZRvK9PPBF3Pil50b7A53?=
 =?us-ascii?Q?0bYx0nn9Dlt6+AQ3WnUcgKsr9/zmKU33WHYj+vXZzA988XYzyi2DF+BlbXSi?=
 =?us-ascii?Q?E3rif2PXT3mf3W5/Yh8SnBRYRSZP8CP32s2fcUKa3VL61SPrYHKCRgTfUNoJ?=
 =?us-ascii?Q?lot+HnRmBuVfV5GDg9iQZMTQ8gscC+Cy1j1ditOO7zDdGCB9up5O9rntoR3W?=
 =?us-ascii?Q?uF1cbvr1MX01MzVs9nmGi5YAErUyRCcVAduMmxiplxvK0y+e6IJuzmdF7Jp4?=
 =?us-ascii?Q?xQCKDUVgRt5VlyzGrbCkhy+TXBaUyBFwlzSK6Pqq1/AEzSfSTnevAhYcmKUz?=
 =?us-ascii?Q?XdN9I78fge0Yf3qPTCtXN0P74LcC1N+fMqn7kEgsB0DnBlRHQ9VJtpBE6fYO?=
 =?us-ascii?Q?LardYJj8yKPx3HhjpEtOOH5iIJY/vedX09ap1liogy+QDV2X1+sE0YpOZ2hW?=
 =?us-ascii?Q?5wapd5bx2zq7iXXA+g/ef9uxZNzNXTqjrD5+I3kDKLoaJl0oigOsiLTUADG/?=
 =?us-ascii?Q?VFz163I3/X/dYgIg7slpBYG2mA9AznCgNUeYavnI3yTZAc/D1Gdr7UR0LCkH?=
 =?us-ascii?Q?Zu952W4YOILnFcun4V5PyEjFVP7/99w1E6nBwrpSl37kCmCGZ4o3EA3CCrzP?=
 =?us-ascii?Q?iwY7EH8QTrJFAC/qT0Mqy0qle7OY+jAAJ+mfhSsTJfOo7LZud01ejWO+4bOz?=
 =?us-ascii?Q?pvakyf1z07oLcL2NAAGkIIwizZeqsA6odCW0lZ0Y76/H/G3zbOzVWy+LHvXc?=
 =?us-ascii?Q?J0xoiaR3Wa5IwBtO8CgfcMjpg3jqRXc1OfxhnU1MKYp2BRnY+243vvXBMrV+?=
 =?us-ascii?Q?Wiq16mS9paOOHcCb5eocQSa9fNdZQCTKscP54b3nXzFZX0jQ0VbQBTf9cP9+?=
 =?us-ascii?Q?NXSAtbVu5cOAMM7nCbtYkgNZL0Uak/Lf+uA/5nCMt6f10JBlPbOuJpw1Zb1g?=
 =?us-ascii?Q?DW7tF5/MfXlbk9xskzVNlZe/hv6JvcmIG99j5DdTmbCCBudYepesl4/UMhhf?=
 =?us-ascii?Q?vmpGLuhcxC+0jqIu3rXCqnIuf4wecVq3FR6OO0a2hnwE2c9hhjJXRZeH7CtJ?=
 =?us-ascii?Q?N8axQWsCwrvtFJA9ParV9tfov00sIBqsb6/7UePY2+M7vuK3lEOZ8/7KUOoV?=
 =?us-ascii?Q?VpVp5aL2RylSbK4nG859tYkk0l3MzucLLbvtomJIMua7bQfVSw+7mKcr4O2j?=
 =?us-ascii?Q?lpc4D1Jb19w9Fobee24vCEDADW/gfi4W7EbahTYpB/5rX1Y9HzoqvWS/5oXi?=
 =?us-ascii?Q?jPyMicrSSSOJAnHOckaijrjmdu1+04d8vq620GiCs6RT9MroheyKIfFwj29u?=
 =?us-ascii?Q?Rg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d18d7fa1-aa91-4a98-9668-08db788a61ce
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 10:19:54.6834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JcyWmzhKPVdXbRa0EWO4spJpLw9617oWIPNauapeVg+582MHJIJS4oHdRTtrGnqfRrllTCFZvA1ulgU7DX2u7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8644
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 11:36:38AM +0200, Paolo Abeni wrote:
> > The big drawback with INCL_SRCPT is that it makes it impossible to
> > distinguish between an original MAC DA of 01:80:C2:XX:YY:ZZ and
> > 01:80:C2:AA:BB:ZZ, because the tagger just patches MAC DA bytes 3 and 4
> > with zeroes. Only if PTP RX timestamping is enabled, the switch will
> > generate a META follow-up frame containing the RX timestamp and the
> > original bytes 3 and 4 of the MAC DA. Those will be used to patch up the
> > original packet. Nonetheless, in the absence of PTP RX timestamping, we
> > have to live with this limitation, since it is more important to have
> > the more precise source port information for link-local traffic.
> 
> What if 2 different DSA are under the same linux bridge, so that the
> host has to forward in S/W the received frames? (and DA is incomplete)
> 
> It looks like that such frames will never reach the relevant
> destination?
> 
> Is such setup possible/relevant?
> 
> Thanks,
> 
> Paolo
>

They will have an incorrect MAC DA, with all the consequences of that.

Given the fact that the incl_srcpt was enabled up until now for the
vlan_filtering=1 bridge case only, this was already possible to see.
However it was never reported to me as being a problem, unlike what
is being fixed here.

I see no other escape than to unconditionally enable the send_meta
options as well, so that the overwritten MAC DA bytes can always be
reconstructed from the upcoming meta frames, even though the RX
timestamp (main payload of those meta frames) may or may not be useful.
Doing that might also have the benefit that it simplifies the code,
removing the need for tagger_data->rxtstamp_set_state() and
tagger_data->rxtstamp_get_state(), because with that simplification,
the tagger will always expect meta frames.

Because of the lack of complaints, I was considering that as net-next
material though.
