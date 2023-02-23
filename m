Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABABD6A0DDF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 17:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbjBWQZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 11:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBWQZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 11:25:21 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2090.outbound.protection.outlook.com [40.107.96.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EB456506;
        Thu, 23 Feb 2023 08:25:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXDaHDj6d49Dcf2UdL+gnfXGuLQlB29SAASJ0U6BmyIJxlIn3ZiXbPCYEZzVXf8hgKb7KHipAvweXxtDuGCAeSsJkGeReq5HwVwiNCOsxj06XUT43g/ZUbX3PLjdUi2hgN4aA69oxhrycLEboo7W6+3HU/RLPXmmcIaDQ2t1vRFVXnr6uKxluf07xJQ25/5A+reImnSPpa9CNRYlrhbPJ2kiKgsEIyUL9I6UGXZxPfTycw1VTmXK9251142IqhqjMUJkRm3ln4qpCMzs6X40+jr+GkEOikHOFW9K0CJaP/WFnWFGD/92R6EcWOueFQ6RijOz+/mXcWvu3CyqdmqKTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uxzrl3L4QEosO4ddDVp8tc8jC1JmRzGUJBMhaAjXrpw=;
 b=gciWdt2vpnhxN9VDwFJ7HgCnqE6wWXcInFl9f0V9uNQ/wcErqGAe6JOMIKErWZiFUkQt/SDeQF+M3ssHoejHyLKP9VgF7+8eVH+7tkSLYS5QhyFA2YV1i+waIEw4WnGSlKLZhpn7/Aej50LW8O6FZ1zwMpETp4WdWOcXmWUtU+Nihp/Ex5hZ3oOTONA3Rzp5ADZtXlnmYBaFZ1kvN+ghl6W4qNwIEyc8NakiDQFq2krgoIlGUEhKrYb9ZwEov/oBnutbV/nbreEOULbewYOci3mrPb2LZZuFjFBgp1ORm34dgts/kGlyBSvyW3e2vgRRBikq0cJ6uqYLYmM8Ly5wvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uxzrl3L4QEosO4ddDVp8tc8jC1JmRzGUJBMhaAjXrpw=;
 b=mjDtggjbA+Jrl/mufARbZ3b63qsb+YfEpysN17ZIFgNrKYaPbLKNffse44+V10QC6El9wjGhXv8WCzAE8teuVZQZXSTKqIVn3F85Xowc1YWcnlEooloyaYIVorLTd3WBdUpRR9oO87JLHP/0IBapS+GDSyinPRr53Der/QQCbok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from DM5PR1001MB2345.namprd10.prod.outlook.com (2603:10b6:4:2d::31)
 by DS7PR10MB5136.namprd10.prod.outlook.com (2603:10b6:5:38d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.7; Thu, 23 Feb
 2023 16:25:18 +0000
Received: from DM5PR1001MB2345.namprd10.prod.outlook.com
 ([fe80::6f3f:5bbb:ca57:57d0]) by DM5PR1001MB2345.namprd10.prod.outlook.com
 ([fe80::6f3f:5bbb:ca57:57d0%5]) with mapi id 15.20.6156.007; Thu, 23 Feb 2023
 16:25:18 +0000
Date:   Thu, 23 Feb 2023 08:25:08 -0800
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Andrew Davis <afd@ti.com>
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        soc@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: omap: add phytec pcm-049 som
 and pcm-959 dev board
Message-ID: <Y/eTZONJh8QdJVP8@COLIN-DESKTOP1.localdomain>
References: <20230222203847.2664903-1-colin.foster@in-advantage.com>
 <20230222203847.2664903-2-colin.foster@in-advantage.com>
 <dd67f7c9-0867-47d0-a201-9316908d9d62@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd67f7c9-0867-47d0-a201-9316908d9d62@ti.com>
X-ClientProxiedBy: SJ0PR03CA0251.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::16) To DM5PR1001MB2345.namprd10.prod.outlook.com
 (2603:10b6:4:2d::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2345:EE_|DS7PR10MB5136:EE_
X-MS-Office365-Filtering-Correlation-Id: 6253b56a-6479-4846-f1e4-08db15ba8b85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DguKHYtM+FZPreT7sGfvOAHmMPk7wSf1WxZKpWIWtx242hiCW62e+qs7QvlPhuUWUL+iBVvrjnTU/AtP6bYoZsovFnOKudkZefmiZV5fYLmFfHnxneTYc4o5Q7CAFoC85Rgnm8vLtUVwSUI9lA3bIBhjCcRz1EXlprtnqAY6hUSr1dn1tuZOiMqaMpfbtIx/PifdGufCE6YeADb9Zg6hnUx/+vgMKd0oIiyOEQc1CGZM6kNPryIlbkhoBSGSj2D45XBlq6zET0Q9FEGpayEh2Zv/iTroKkQpWLs4CFX0Bg6b6JwrldQ6gfj89hVnK9m09WGhB+wADCBTPLAH2uyNSZAeCFQmr+sKGp++rAbdXuHKjvwaqUtHQFt35dFWbrM5LfHr2WHPOsQwHB2CVry+L994dzYWL44z5Z1r23VUD8Z5l4EaIT00u0FOzfTIsmQnJwNL+hjCI9K10b6Gwaf8cf1C8b/W75uv94jFr5Sa8unx+w7ZsyKa7K6s5zEeR5U9gcPRipKL2t3mfpYTcJVnbEGIV9upd0ZHjTMRrVRo3xHsmuVRkHFFf2Vhj5ThiPMioMWMk49VHESciInexu2HJQABZRhlKl6TuTyfs5bHHR6ZoPV19HppRhTGkSvwmeUEUSsp5AYvkQx0T6JnHNgD8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1001MB2345.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(376002)(39830400003)(346002)(136003)(451199018)(7416002)(44832011)(86362001)(2906002)(66899018)(38100700002)(478600001)(6486002)(53546011)(9686003)(186003)(6512007)(26005)(66946007)(66476007)(66556008)(83380400001)(54906003)(41300700001)(316002)(6916009)(4326008)(6666004)(6506007)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xWlsRQUwF7D7AahPB/aCzAjEToE2Xgy/UzNdI9E27X3a7c7uZXQNSBga465F?=
 =?us-ascii?Q?Bu7KMc6wIGuC3g9Z7IGU+eLdZPQ5Ypz81lZ6ZCnPCf/gVlgCxHVGqLBNn2u9?=
 =?us-ascii?Q?cVQXxKBn1YmIl7wa01jhgRR22Icejw8ycsGKduWo2HHoUSgpVMH4HOL6k77Y?=
 =?us-ascii?Q?XpYEOGDe15cSSxeEOG5GYv5JsIJNgsFiboz2w4mmr1gY7Z9k4gWPg/a3LAJx?=
 =?us-ascii?Q?cDvePTt/8Ve8dWTDMNhChAi818dgo5dE7xO3Th3UrqePWoi1tjVdGKohv33P?=
 =?us-ascii?Q?5x1QJCWUFa6vDfkzVUKRiRlcHA7naPQSpfoICRTOCHzCqUlXYhc6s9gsZAAv?=
 =?us-ascii?Q?/Pp7aIoTq7QOp/EHY+W8tksdT3fiof9Q153zMY8YtHsNvNXNQp6rQDt4oADi?=
 =?us-ascii?Q?z54YPEsiNd99/T09efT3pguNCQMkGsSpEDYeLD20Vqy5wi8UjPrX/GNJBlJ8?=
 =?us-ascii?Q?3H5guYAchLw8HH4NkNrqeUwnVD6Rdsehb+d644IAN0uadg88uLttcVcG5afX?=
 =?us-ascii?Q?4stJ7sLLJCPk8cF7WifzTMPKaJKXP+XRTbkskYoVArqPQx2aRk/0i1tTVRnW?=
 =?us-ascii?Q?l/ft64sj7DuF3OMWfkQVBTKMZvqpJSmvEGJWJCqbWrOki/ZOXfu1eZe+Kqjl?=
 =?us-ascii?Q?D4lJlr1+BsdrQ8qoDoRoiZjX7tzy5gW8nPN8x2HhL+0O6T7ohxWu+ANsBsXa?=
 =?us-ascii?Q?2pQqoD8mUwh4SVzT+UyH4pQ8+DFf9jbfNyacn2qqst0hglvJ0fR1GePaV63R?=
 =?us-ascii?Q?qApIbHVcXWzy0oAMghqlYgex/IzTN7KXPzkZ3r9MPOQ1Ynbci4QpE501Qx4n?=
 =?us-ascii?Q?ZWCARgbdqbFbCU04NLr47zcclD7CcJXgtMMawCAq256SMIXfCOmVyBmedJ5y?=
 =?us-ascii?Q?UboLZCPsBQWtxSjX7uWfAO1ASnkCCxV/yxgEcfHiKqtg8wm66MvQklw68Y6Y?=
 =?us-ascii?Q?OOWxjsHXToP0faCBUPU1Pb6t0lN63OdGk527kgJQOI9v6nGPr55aN0g0mGqK?=
 =?us-ascii?Q?o15KcpgFPa8OsbCjCEgFIpvwoT177cfampAc1jnKmYQyDSpUxZeT+cc2ww4T?=
 =?us-ascii?Q?UDL0e/gwvYyVBP1ITr2ch4lYmmeBasurMEbH+FzRE7/RPdUEpSPgvnlpd/1K?=
 =?us-ascii?Q?g7kPbR0fgIG5aLkcnBc/BZxgF1VJbMqdfvq8k67PJCSYjSigT6egQGSYzzUI?=
 =?us-ascii?Q?S9GoHuO2Z1yYY9K5zdPAAIkuwKmKV+rtKPM71iYL+dG7ZIrIs3d/nvqSjj0Z?=
 =?us-ascii?Q?YVd5qaPxtMKoVHOFhm6G80fhv3qmcVLvHCmUSozCWxprYzyi3SZAzeYiMTU8?=
 =?us-ascii?Q?zILAcwxuEwmgbjxrVxhd5B7zOEEtm6UzagDwGDhHcR4HTxQel4v8mST+0Gir?=
 =?us-ascii?Q?QZCRLeigUlsZAn5jYVIWmn/d4HpW0NJgarO3J6GVG4CYqqN1x3eMvmjWkzCH?=
 =?us-ascii?Q?P3s2AEXdegDOLY1gcuxQG6oP+Cx8Ll5+iuDmNjaUF5k+l2Z4IuL160/EJqbO?=
 =?us-ascii?Q?6kLrJ1UT0IPV83S9ojORJHDRzmGW/bdIzQAGe1a/YXE0zsRSdtWBGgUQUWKy?=
 =?us-ascii?Q?8LYSPDUryFyM4/gkqba4iM8HPq5JmDR3EaznpPHBeS9NrI2TXuPMmdwVC3PX?=
 =?us-ascii?Q?WXX5efL22hkfPv+yNHZ+kIc=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6253b56a-6479-4846-f1e4-08db15ba8b85
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1001MB2345.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 16:25:17.9154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qf/4dbExY34uGYmESSQVFWqHc7CT4heM6iCmy/f265Jszy7/1WloSa2S+ldXitD5+AoYsrQXssBBP0fEX/MCxU7QkeK6A/M2UOS9TBWe33c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5136
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 10:00:50AM -0600, Andrew Davis wrote:
> On 2/22/23 2:38 PM, Colin Foster wrote:
> > Add yaml documentation for TI OMAP devices for the Phytec PCM-049 SoM and
> > the Phytec PCM-959 development kit.
> > 
> > Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
> > ---
> > 
> > v4
> >      * New patch, based on a WIP from Andrew Davis <afd@ti.com>
> > 
> > ---
> >   .../devicetree/bindings/arm/ti,omap.yaml      | 29 +++++++++++++++++++
> >   1 file changed, 29 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/arm/ti,omap.yaml
> 
> How will this work if I add the same file? Why not take my WIP patch, make
> the suggested changes from Rob, then have it as your first patch in this
> series?

Is your WIP intended to convert all omap.txt to ti,omap.yaml? Or chunk
off devices one at a time?

If the former, when your patch is done it should be a pretty simple
rebase conflict resolution. If the latter (which feels more digestable)
this offers that template. This was Rob's / Tony's suggestion, albeit
before you sent your patch set.


Anyway, I'm happy to do any of the following:

1. Take Andrew's patches, add these references and re-submit.
2. Keep this set as-is (with the typo fix) and when Andrew's WIP is done
   it should be an easy rebase before submission.
3. Wait for Andrew's WIP to be done, then submit with this update.


I'd like to avoid #3 because I don't know where this might fall on your
priorities list.
