Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76841621CAB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 20:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiKHTFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 14:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiKHTFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 14:05:16 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70122.outbound.protection.outlook.com [40.107.7.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE855663D6;
        Tue,  8 Nov 2022 11:05:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlNn/85bg7rOJmTDmpH5ShFEGHF0VbYL0qxxUXHIxVS4AJDPt++XNNyorrf+qMok3OLmyMhnqDpIlp/2g+Gw7KWEDztoMzooAunpGGQRZGnUREzPYgsKGSZ9Z5iWISNjrPzpCjI9PBdDqPfDEqL3on7I5Y9ySwdxbaW1ZoGaKscJwSMIytpxKmD8asIWgfnav7wXa6rz6xP+ajkaFkVh2+MndzBYJQ036bNcD72DZvMdXd02uAd6b7kl1pUfqy94I/kQMLB5qzkOvlijIHXDVP+LQPXhRG/fpVSnGSMXtKBX6Q7inYgGkhLEX6PnH/6ry+tYa3L/xQHhQAooPnBkxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jry0aet9Bn+6Z/t+2gdCLPgBagNeA8BbT/YGzoAI3Ak=;
 b=bRO8uW6hHARGCs1cS5NJPfWug0ZCQ5m3EbbICENLwA3HgB+6DMri15SUFthdETtl1Iba+yo//FydsE1Zow0Dwh6fnQEr5o6nxXWzigCqBh4r+Mkcg2XzLF9WruyK6FkZcNheTFmEmiC+wEyThNk7jEhWBGx2a78DIqllXLg5CxAIGviU/Wmi/OW95zsfLEVF0oyGbPlNZemDWCUqnLzGZTLyjKgC3EM+UiGSYCCMOZ4R5ScgbdX53s7m5x4mQ2ksLtyJdI2acqZbj6cSsFOt3PN/lypHB+aF6XFdfQvDcCqNlO0ZZK7C5oYobVc5CZhut9l/poQV/wm4X6aQi273Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jry0aet9Bn+6Z/t+2gdCLPgBagNeA8BbT/YGzoAI3Ak=;
 b=SysCuo7tmg9gsycra1oaoIZi5hOO+EOWPJRJJx33Kw5HaZkj+ruZWx7JJ4+8ugAdvcLDReXAC+H7vofrwM9stJvlxzMlMRwlamX9YYJsy9ZMRB4bBOMjE2bDaH8A4t2Dvn4VC5UfSf/sic+p0DQI6SKqSbomxnflQq2iGjoXUkk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by AM8P190MB0817.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:1d0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 19:05:11 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2b03:a6ec:3529:b969]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2b03:a6ec:3529:b969%5]) with mapi id 15.20.5791.024; Tue, 8 Nov 2022
 19:05:11 +0000
Date:   Tue, 08 Nov 2022 21:05:08 +0200
From:   Vadym Kochan <vadym.kochan@plvision.eu>
Subject: Re: [PATCH] mmc: sdhci-xenon: Fix 2G limitation on AC5 SoC
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hu Ziji <huziji@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Elad Nachman <enachman@marvell.com>, iommu@lists.linux.dev,
        Mickey Rachamim <mickeyr@marvell.com>
In-Reply-To: <VI1P190MB031779C030CAED8026D53D1895259@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
References: <20220808095237.GA15939@plvision.eu>
        <6c94411c-4847-526c-d929-c9523aa65c11@intel.com>
        <20220808122652.GA6599@plvision.eu>
        <3f96b382-aede-1f52-33cb-5f95715bdf59@intel.com>
        <3d16ebad-ea6c-555e-2481-ca5fb08a6c66@arm.com>
        <20220816205129.GA6438@plvision.eu>
        <94888b3b-8f54-367d-c6b4-5ebfeeafe4c4@arm.com>
        <20220817160730.GA17202@plvision.eu>
        <80d2538c-bac4-cc4f-85ae-352fcf86321d@arm.com>
        <20220818120740.GA21548@plvision.eu> <YwHOCHmKaf7yfgOD@infradead.org>
        <3b88438d-1bb0-e980-b4db-1f8663dc6042@arm.com>
        <VI1P190MB031779C030CAED8026D53D1895259@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::23) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
Message-ID: <VI1P190MB0317DC34760DFDE69F69A700953F9@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|AM8P190MB0817:EE_
X-MS-Office365-Filtering-Correlation-Id: 303431f7-2ed4-4ba1-ff60-08dac1bc2864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ee8wDGU7dx+22T9Xsy39NBEymZgaDBfNWdeFRF8HsY9/2LI9rZWDGVxGKH9we1ZNFcJLiQLYRa/KShOKPrbs3IbueyoBNlOP9fSQxJ8hSlRe9nsFgwvILGTxk7nqnc9rDmohtGbhS0P4fYODhqkIAkt8PUURxkIbNxFgj5l/BVXFe2tkWMawt/FPF/gL14GG0f+nxBQesh8tXNQFiibf9w/bTre0ADaw9xsUhca0cFnf2dcVJ+lQgfr4pgiKfI8g5p6JJ2NorIIh3+QefClyvkfHacNnq3yLQAGGQLU0TpbavF/yVG33FJdc1Q2iWdQiGlSgAGejgkEvM2j2a6UpbvnhVJ0ztYs61qWeJbexTj3FKt7PfxGZu8AEwWr852adJJuOI5yzhKPGG43hWG3Q6neXKzDlibFXQyp/ropFwlLenjiOW6kAGvaWAZHyguEz0DQPAsiihKHFtXRiUX+y/tS6AxUJIrUDXT7vJQbFcqByr2BQjLE7guAPSzy3DuBY14jXEbDwQMeMXZ2p/R+81IMXcedCuaLfRBMmA0C+EJEFm9ugW0R1XdtQa3lrSL/j8+4Szaxw/Z6JQsde0kTbCHkK7lFrpxZytTeHowCJmhF74LOSR1XAHjGfJK0Hl5ynoJr5gXXq7B7H5DF0G/cFVQCC36pSJEazkOjVgBe3+c+0Idg9QKgonBbN28b18+37+82+oGIisktfdjgn4XwrJ7OaQz9dLk9k+hPMa8+guvVeYuqY6WJT8DdFA/oMFi4B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(34036004)(376002)(39830400003)(346002)(366004)(136003)(451199015)(2906002)(8676002)(66556008)(66476007)(52536014)(41300700001)(7416002)(55016003)(83380400001)(38350700002)(8936002)(508600001)(66946007)(4326008)(110136005)(5660300002)(6506007)(6666004)(7696005)(53546011)(86362001)(186003)(33656002)(316002)(9686003)(52116002)(54906003)(38100700002)(26005)(44832011)(41320700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aZNP+mbv7iZzj6TMjUZMmeIArr405bPayBcjH/GTleQn5IG7IJpFWIDc/kdC?=
 =?us-ascii?Q?tHdOgz/yohCj4aQmBn0YgDaIRoUahoDgzDAHlqimlYyqWFmWILnlNYpvaCPV?=
 =?us-ascii?Q?SHS/KlqaigYdYpwKOYgIpl6nuWsSWLnYcmhlddUzlKEqNjw01paKkYh3/ylH?=
 =?us-ascii?Q?PUlyXZ4F+OHEIgqsnNiDXp0B5SYWr5KgUml6ZTHtstG9cVLxMOU10lG+VsfL?=
 =?us-ascii?Q?xaaQBj0YgOP3NgjWkuWmGmERPAtWR6GMsE8A54X3eJBlKoSanf9glWBM18IM?=
 =?us-ascii?Q?aC+mSOd+suS1JrgwMtwZpTxqK7hm6QtH90qqMeqM0wLw3ZYiLGt2oyb+O5+z?=
 =?us-ascii?Q?Q2IRXrcdFPOGK9Bk55mt88SC895BCPuUIhYzSsv1iD20sndobZsbiVq6tGCx?=
 =?us-ascii?Q?Z+e8loAqRGIl2El61afZMdbjW6xkU9XagHDJJyYVWnCK9uBzKsZ8zUPWow1z?=
 =?us-ascii?Q?eOVEb/icw7WkxRi/f/TZ3zlHiVW3dcG5blXDoTEn+/YzdLPhD3dVAA+d7O+W?=
 =?us-ascii?Q?XVu5KyBukeGrH8AWuVu8IPtNqMG8zPATrakkuWL8WMXvICKua2iFUPvxjqli?=
 =?us-ascii?Q?NK03pKjC9zj90dRCqMs441YRxva7ODtNVtMsyO31+bXB93rnp/bkEdz+pW3v?=
 =?us-ascii?Q?vSH9uz6v3Df2PSf39nT5/To0HBlgQ8xrFtvTVjBRuK9kwAollvN9/RYQybDE?=
 =?us-ascii?Q?orvmmh68gxG1Rp4AOxKNtr3p16KWGbV5UZ2Wqe99mLJNtzTZ+pPZzhaWW9Ws?=
 =?us-ascii?Q?tanNIdY85ZucewJboZavn4EoHktUKiWrbCQ7FMyPW2EwTX8Nbr6paF/ral/P?=
 =?us-ascii?Q?2BRabdHj009tQXbCmdSCvBDzapwJi1xKtEUMh80t/VG7cTUQdvY/Q2w0N4T4?=
 =?us-ascii?Q?24qd2IwpbOqXPoyUXeRDJMWG5Ok62b5YQElh223jSAr+DJ9RSMi2WxMMcg18?=
 =?us-ascii?Q?ky622fEzRRyhiWIdsBU2BA8vdycoSiKwuytLUpOuXyKwPYFEGPDTPFNJtH5e?=
 =?us-ascii?Q?1W5+iEfvBZ8PDc7+DmUOkZV+fZ+3ihYo8sfyMFChTkgBLqg2oRsQSOFk2lN4?=
 =?us-ascii?Q?s8UurUkmO0vE1GGjFHPb28/crYpzQHFllPNrrTJ6ox3fsFmiT6ldfFLWBYnV?=
 =?us-ascii?Q?R22MEFDlBtSz1ZtRphr6v2n+eQv5O9E4FLpy9kD2hCPf4GH0woaJ0TzxnFsk?=
 =?us-ascii?Q?c3e3wlDKmRUn28mZLGg3oZR36fFurdqIs30eLHUOh4ju1CGZVDgyIymjkvaE?=
 =?us-ascii?Q?COCqnXgRMNotSyI9KhDMj2/DHD5ED8MLOMkswNntsTnsedkspsQcimoFB4Bx?=
 =?us-ascii?Q?IPGVehEnTKrPC3x/ybtQeV1x11+/Y+RIyJNiq6aVGVwTrWT1NMx2nQEM+Mul?=
 =?us-ascii?Q?LIzU0wbJjdq+JUqfrBblvOlnm9hmxGro9gVjPtH5IM1daXyjtG10QP9rLbur?=
 =?us-ascii?Q?u3Ox5Vpnmb7EVnLm89G/lIgGEvVJo+0CWn8c888/xgzrV5Gkm1XpLss7JJRy?=
 =?us-ascii?Q?MRYe37rCJCNW7gliZtcoqP/3nMaYToKy1WJecLP9yB57jQvS97Br3GPa/fds?=
 =?us-ascii?Q?gB8MHANJ82Gl7anf7ibtcAQto+4gK45cUg4XLVp5xXLHhNQh9wysujEzT4sK?=
 =?us-ascii?Q?jg=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 303431f7-2ed4-4ba1-ff60-08dac1bc2864
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 19:05:11.1284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x6pmUZbP/0BtVgRSx1/8g8gdnDTVM5onwWkBQR6DaZfzYDqeh5qT+CDyXduSOhAeyWj0GTr1zIeVJElFNRm4SiQTOm0LKRKUAePerBWcGus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P190MB0817
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Thu, 13 Oct 2022 09:40:00 +0300, Vadym Kochan <vadym.kochan@plvision.eu> wrote:
> Hi Robin,
> 
> On Mon, 22 Aug 2022 11:06:43 +0100, Robin Murphy <robin.murphy@arm.com> wrote:
> > On 2022-08-21 07:17, Christoph Hellwig wrote:
> > > On Thu, Aug 18, 2022 at 03:07:40PM +0300, Vadym Kochan wrote:
> > >> It works with the following changes:
> > >>
> > >>      #1 dma-ranges = <0x0 0x0 0x2 0x0 0x0 0x80000000>;
> > >>
> > >>      #3 swiotlb="force"
> > >>
> > >> Is it OK to force the memory allocation from the start for the swiotlb ?
> > > 
> > > It should be ok, but isn't really optimal.
> > > 
> > > I wonder if we should just allow DT to specify the swiotlb buffer
> > > location.  Basically have yet another RESERVEDMEM_OF_DECLARE variant
> > > for it, which shouldn't be all that much work except for figuring
> > > out the interaction with the various kernel command line options.
> > 
> > We already have all the information we need in the DT (and ACPI), the 
> > arm64 init code just needs to do a better job of interpreting it 
> > properly. I'll see what I can come up with once I've finished what I'm 
> > currently tied up in.
> > 
> > Thanks,
> > Robin.
> 
> Sorry to disturb you, I just 'd like to know if you have
> some ideas to share or patches to test ?
> 
> Thank you!
> 

Since AC5X eMMC controller can fail to work on boards with >2GB memory,
and considering that the best fix may not be easy (as it requires arm64 infra changes),
so would it be OK to use PIO mode as temporary solution ?

I understand that arm64 changes might not be trivial and it might take significant
amount of time to implement considering this unusual case, I just think that better
to make eMMC working even if it will be slow.
 
Thanks,
Vadym
