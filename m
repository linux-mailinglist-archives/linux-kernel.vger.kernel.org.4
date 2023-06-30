Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7A6744025
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjF3QxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjF3QxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:53:08 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2074.outbound.protection.outlook.com [40.107.7.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF443AAF;
        Fri, 30 Jun 2023 09:53:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCBUOkF6POgnf+a0nFwH+xcCcqyPR9rLudxseM4VWfHe+FUuDoJh8BRAH+3EFYdmggcadwBJgHg5Pp+gk4zW+1Qy4jeS1DDS5/j121wcPxxTybDb4IN0I9CRuvhTiwGJTeG8arvj7yx3oQQ7rNEG5vz/nO4xpbKZ73hG+mJc2ticgUybuFZGt1RjmPx4p7XENBJY6HqOHRHRy2VgpBc0BQlD82Jlpj5fT4E30xNwlSxZEK04ejitnXLa6NV76ZeQegTeP7JU/3VMuVmhZcx8RwDqC/dxjycp/ve3Uaspje1r/hKhnWQ2LJOSjBk11OJ6uJiP5uPUxBSOjF4GleaHzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mu7oh/L1Tb54N0kOgu1lgeW1eLRDI9ZG6rgyZpaxgMg=;
 b=mbNasMqrfABN6NxW9H/9w624sOQ5fc1jfT1YE/5BXDT2AynoPlLAox9+mEcUke1SW2I3bVOdgYzz4CwpFm7A2J0Q2dIco37gIWKTeEIZr9V48lVBPse/Efzi6GvhFfAsj+DLTAiGu8q9DDJtemzkHdrysj0Dc2+KWzQrgxFhT8167i6TK1OMF7aK3B0Latm8XkbvzBx5rBMkKHBy81uRKTgyTiWYgpV6kDtV62zYXJI9NkgFwNP9MYzTyU8IuP2cO2/jA2UHAUA5tbPDe6F1LVUxTY99f1l9qO2eF/xcumFfxlhSGmVQN7FE6AVa6N549Vbq2hfW/RV4QXr6RV4lCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mu7oh/L1Tb54N0kOgu1lgeW1eLRDI9ZG6rgyZpaxgMg=;
 b=DaII0QvGmvdbGmgkukJCChzNhox/Dvzmrfxr3wTye0ZLuElwjFPnnP4ZVk3StyXLHqUBdJtr5mK/U+EjLUtissBx/MY3FwAaGIGdPUA0MA3ORRfhIkiQL0CdiGYIsaKygyn+C8mbEhKFsgA1rvHhtak4ewoBonLNmq5XPzs8xEo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM9PR04MB7618.eurprd04.prod.outlook.com (2603:10a6:20b:2dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 16:53:04 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460%5]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 16:53:04 +0000
Date:   Fri, 30 Jun 2023 19:53:00 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Simon Horman <simon.horman@corigine.com>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: dsa: sja1105: always enable the send_meta
 options
Message-ID: <20230630165300.jmy7duyrqj3gzjmp@skbuf>
References: <20230629141453.1112919-1-vladimir.oltean@nxp.com>
 <20230629141453.1112919-3-vladimir.oltean@nxp.com>
 <ZJ7aG/tzAxutRoeo@corigine.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJ7aG/tzAxutRoeo@corigine.com>
X-ClientProxiedBy: FR0P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::15) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM9PR04MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: aeffe937-5f57-4524-12db-08db798a78a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GIoFGm+MNq78K43MKZcpOtnodHPTBxe7vdhT5L6zz7gVgMti9zZ+NODKLEaMVnSdRBnzCjc51uN3vMHd3M2QtkWLq1MubdWBcmf/SWwgqN+SzZ4fhk5ipUdOg1N8YUVBaZjxB/eU18255H8bWvIh3Ju3CoiBpmoOOcMwsrXTHEg2a3Hb8OIvq4ZujVDZ2OpBEqepFpG99ZDsSzI+IwBeF4+v5KeWQtmj9yWTUZH75Rd5egvvSTlCiHDgF6cT1Qzt276aVC6mLjj5QQDc6MP1r+JsgzXwqrU1oyzpkqdOspTaYwov5feZ22QxKaBkG4FBBnNfDEmlXTo7UdzIaWmrOqwYOGtHXRBhfJVs+B4wIsTc3tMLRp9YWCyOAn643am4ZcXnnsz32ydntuWqwdREqy7wMW9vv6SrryX1Fqfz5DsNaKNam8ODADLyTSt0GEw/dLLoow3vAerCAD74YL8/EzU++6PRb2wYeFUbg0FV1S84a4m8hcsFcOPwxkEQ9y5Rzhs1M6ZyMjAG2O1JIIAK6MPKJEhdc3pKXdri4xjhYv3ZGIPUBghw23oDiRRnVWYx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(451199021)(6512007)(86362001)(83380400001)(44832011)(9686003)(6506007)(26005)(1076003)(2906002)(186003)(41300700001)(38100700002)(33716001)(5660300002)(8676002)(8936002)(54906003)(6666004)(316002)(4326008)(6916009)(6486002)(478600001)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WCpbz6hHQ1i4JXLALIyOF9szcQf3yXe60pyyPUwT1EOf2rRGV9R9ymTeABGr?=
 =?us-ascii?Q?90wgcCRLSHkXHG2psnb+GqOJk+Iw8DZJgrU6YHhkNbAbodzIdKxa1IN8H9Oy?=
 =?us-ascii?Q?os0Q+lnNvdOWqRRMhUc/ld8jj7qn7LJj03fmNw0o/1bjNoKZc6M/1vZqoQJT?=
 =?us-ascii?Q?3FxrQiFPm5B3QBAAvXyiLB+hRCL56fdCtjylYXChCiCZPlycFiVml+nkz4cz?=
 =?us-ascii?Q?2eCk0jZxtM1T5ROe62s1jTU7s/j30YPj9z7gT/Fhs5DAmMNsYw5o7/C4WRm0?=
 =?us-ascii?Q?H2mU59HA0E6QNn+rVgT9834Aw65YYnezCusaSZPSJa7Bu1/f5yVZLlRfl7vo?=
 =?us-ascii?Q?UEIuKkpIpHEUnF5MVaGJmKoInLvz3+5gElPUPGktWxovGGGkdXGXN6ECeigz?=
 =?us-ascii?Q?oueRSKc3B4BcM2wzJDtgSYXGN9NfzRx94HxR5sPipVp2rQusLWyOYIKjyThv?=
 =?us-ascii?Q?5L1+8YTu+NsVLrDmsKzjcq6/6oFLMYiPQfWfZC1zBi6YcbfiMUPsZlEeV8Vf?=
 =?us-ascii?Q?1fPisCH/WG4TU++gKr//qTz3DN0mdjEckwcLmWNMWF2E5SyQOLyIYuDAIHoK?=
 =?us-ascii?Q?YYlqWq95xQQ2GPSYMdt7rr6MvNDpJruqL9BjRqlktNgKP+sWdZ0OgZ7VfeQl?=
 =?us-ascii?Q?OuybjCns3u577Edq2z2Oq7XXnRuw86WWgm3bMEK3osez88zvSZMB5p6lauYU?=
 =?us-ascii?Q?/Z8wd00xE/RgEF9SaBsJXjkl1+4ts/NYdhV1NW5Dktcu/1VMy4LnMYitQCwR?=
 =?us-ascii?Q?4R7Kt3lLQ5VLAcG+elrOPA7fbJIpSIXj/dY5ZRIBW1tuUCJo4trv3PR++akQ?=
 =?us-ascii?Q?7rRVl25LgdWdY/bbUypfZrtVgmr2/KDZsLPfqHUTPmycbyYADyMmXgb/ULDS?=
 =?us-ascii?Q?rkGKsJhq6UrN9YWe6QN2j3sYMgaWrQ6lzouDjtzQd3e9QPv8O4NUu6+4bVRG?=
 =?us-ascii?Q?TqHWGAZy/Si6ptiCIB/qU3rcJh9JO3RRxioHiQtXn3LC/0PyjjRVnXjYHIYb?=
 =?us-ascii?Q?fd7oxajzo0osmXOFFIRYCcQZtqdYfzbIxZeEVGV7SICNfoVWwdiqjVg0u5dg?=
 =?us-ascii?Q?pRSy3QaN+oDDbv5d1WJkCwRhXFv4ZpXaH1MFLfJSuf5IeRN9vCnUnUIjHtUV?=
 =?us-ascii?Q?gOhylBJCUFq4fursVvvqhxPcRmWfun/gG2LNeNDm4W5TUfx00Ab95LAmH5gF?=
 =?us-ascii?Q?+XKSQnSh4aSKfg2GBzqKRjjLuR4umN7tbfb+6wkwmjzNtTGzH2YIW+4Pqzrk?=
 =?us-ascii?Q?vSCOhX4gMc4rWR6PLOEO3k/wZPYyYT8PE1hGzOusGjjVnWUJTuOFFuo+DQIC?=
 =?us-ascii?Q?EFhZxvwsKFarKQ6Zq90WCmqDGc5QnqEOqYdefvqLLI2si7hhYYDJ8fiVWvaz?=
 =?us-ascii?Q?lUYhbKIP8H+SzfcxsIUZNtamycgbyIW+oemA7swAO2dBVxyQOYxeJayQqZNI?=
 =?us-ascii?Q?il3bsz0JYBoR3RoD3qhWTa2GS9nwEPR2jvAkvB8V+y13GznRrgsQldKY5jai?=
 =?us-ascii?Q?2qQZkTFMMsq5LjEJREg9bboEVaMp04xQKT3FDuwetrZQWzjplV+vKh8v5Hgp?=
 =?us-ascii?Q?h1txwc1CiKqwyMxs8HUGeeJF4+SRRdwLfh/Z3t+Eb9JQdtHOmQ3F3E5B67JG?=
 =?us-ascii?Q?dg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeffe937-5f57-4524-12db-08db798a78a4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 16:53:04.1027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IGDCOcy4Mw/+SoMz7iUmM2u9HqyY4SQ/dlwvDbHbB/kapUIedt8tYt/fs65349nyyzwVPUDRuXAKgLl9AcfHrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7618
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On Fri, Jun 30, 2023 at 03:35:23PM +0200, Simon Horman wrote:
> Hi Vladimir,
> 
> this patch isn't that big, so I'm ok with it.  But it also isn't that
> small, so I'd just like to mention that a different approach might be a
> small patch that enables meta frame generation unconditionally, as a fix.
> And then, later, some cleanup, which seems to comprise most of this patch.
> 
> I do admit that I didn't try this. So it might not be sensible.  And as I
> said, I am ok with this patch. But I did think it was worth mentioning.
> 
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> 
> ...

Thanks for the feedback.

You're saying that it's preferable to leave sja1105_rxtstamp_set_state()
and sja1105_rxtstamp_get_state() where they are, accessible through
tagger_data->rxtstamp_set_state() and tagger_data->rxtstamp_get_state(),
but to only call tagger_data->rxtstamp_set_state() once, statically with
"true", and to never call tagger_data->rxtstamp_get_state()?

I probably could, but I'd have to delay the tagger_data->rxtstamp_set_state()
call until sja1105_connect_tag_protocol(); it's not going to be available
earlier. And this is going to be just filler code that I will then delete
as soon as net-next reopens.
