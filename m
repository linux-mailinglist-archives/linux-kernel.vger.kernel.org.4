Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69404700DD6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 19:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbjELR2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 13:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjELR2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 13:28:17 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF14E3ABF;
        Fri, 12 May 2023 10:28:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfXXg+B5aT8P75Ool0pty+AgyZV14B5ZXtFvM0VfPNrs021Sfz4QVZVLR8ke3TkwsM3G2G67jb3DFBoHrbKkE6/OpDD8CMew9ToVdoVGMTYd+cYZK5JE7eYOYbYZ69PImhNGWgbUzyFB0dUxLFQdYAk2UlLsyeQsecSrui4oIuwlfcd36xjn+9Mi1+dx7hUfWqz5Eqfwr/6ukE2aA8meZe9ELAjoPY8d1a9ZiWuOCQ1hlNX8RP/YFQ3fr/4kokGevv+vRiyv7sGim6rem1CsAKj1jgX5VT1mFt8C5wOf50MFuRaD0HXKFMe5UHCFa01GqZgIh8q+3RMVSbK2rDlcyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lk9WolCSn1nyU6YHKLlo5z9uW5MkQStN7yBSlOd8bdY=;
 b=JofOVgltiprMaXOwDcoy2TCVCUl9Ee2dFqi6rXZvsRAH4h6t8d8FlhfLPv549w1pgqqIIroZO9TTIccPcFAl9f5zC+I1clFupJ6Uw6fyjAMt6OO5Q/ZbH3z1C8DVO9wfj+xqGiDi1JuhU5TCKxawXGH0pkrKbkZNYi/bLDnD6cM0idW3oE4Af7vEygPxtGnqGWZsJxX5kyrKjM+yHvwyz+ZlMFKnN33IKJfD/3of3Dw2F2M48Ih6FIy6of1gWgBWK3+ITWFNTvx9ElrNka/Hn08aBAQdvkecXIghdPyhLPfayCts9yHpoULvHDrkzTPNc4Yv0F6eezkzwLipyF58DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lk9WolCSn1nyU6YHKLlo5z9uW5MkQStN7yBSlOd8bdY=;
 b=Gpd9MnScBkZngTj3sggLihg3PqTZgynDYi1O8ptl9EiJ0qXjcMWP3ZAlFpxFZiU/YcRiEbiGnBSHyxHlZvqRdpVDI8RRzPM1Et2b/Zp71rQzr2124mNeLHQ/uUcR4ZhNQtPZo3OQ2Aq5Ko3sSa14P+eF7iTz3W2Q4W+DXIgFbr0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by BLAPR08MB6834.namprd08.prod.outlook.com
 (2603:10b6:208:30f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.25; Fri, 12 May
 2023 17:28:11 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542%3]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 17:28:11 +0000
Date:   Fri, 12 May 2023 12:28:05 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     =?utf-8?B?VG9tw6HFoSBNdWRydcWIa2E=?= <tomas.mudrunka@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] Fix freeze in lm8333 i2c keyboard driver
Message-ID: <ZF53JVcb8UJQFmfP@nixie71>
References: <CAH2-hcJYVpBNwnMS6qUp4=MW8kSryDAz7G5cNA8R00QabC9bjg@mail.gmail.com>
 <20230503153231.1136114-1-tomas.mudrunka@gmail.com>
 <ZFMN5nmqLAX170SE@nixie71>
 <ZF19yOojiaSbo3vS@google.com>
 <CAH2-hcJ8XxK060O-QCCBz+=cKk1HbT-aOKQH2EOY=D=xttvz7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2-hcJ8XxK060O-QCCBz+=cKk1HbT-aOKQH2EOY=D=xttvz7A@mail.gmail.com>
X-ClientProxiedBy: DS7P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::33)
 To SN4PR0801MB3774.namprd08.prod.outlook.com (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|BLAPR08MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e33ddab-7f25-412c-0913-08db530e426f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MFm/3d5Hv+oc0EGaLWoFsOLJSjS1xJYt+xrOhPp5zKeTPPjOvz6RDtTsdhde0zlhep8AZrU5OmE0WO4uEEYcXfGxDkdvbC+z/OL5YwQbVtLvfiEDLWHCM+Dc2uaMglodRr996t57dLOPQU3Ka8qUzFE5kDuMakiE/WfWHML/0O/A4Eahm/Q5P3i9x6i0MaCfivtB0cpHSJyMbK1UUTfMi0PPPWYLeXdRuFfEZ/5QjTOhYMyvm8Jm/TYlXGGl9hcJWhJkZe/W3C2Eo9D2aKBupKVKHPuapsdO2BR00cbnc+EaEyk7U5onPqfDsmgbbF70dctT9FrMmXle4a1YmvffiebWBDcha3vqAIxa9BxlLhMxCHtOE2EF8SB4t+JY8f9zbg4LYvMlrYn513i2/CaPYUmIexfCJjV+72PbREq900VXXttUsYFBVHSgh9CsD6RzhIZe8IcoTcZ2ezEF7cDCRZ7/evlzduVu4LP1lWW+lXUEoXFPNmXofQHKIg8sg9+tx710YtFAFeVGgP90iFeurJrgzA1BeMQEOzivJBOaDbIk5FBqqW1b31QEOIxKYyCO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39830400003)(376002)(346002)(136003)(366004)(396003)(451199021)(83380400001)(186003)(2906002)(38100700002)(86362001)(33716001)(66574015)(5660300002)(8936002)(8676002)(66946007)(66556008)(6916009)(4326008)(66476007)(478600001)(6666004)(41300700001)(6486002)(316002)(6512007)(9686003)(26005)(6506007)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVBIcHJ5c2gwTnpLTjFLTlpJZjBQQm00c0IxZ00veUZNNnZXWXk0eDFTdU4x?=
 =?utf-8?B?ZnRTcUxra1VxZkV6b0FIYjFsQ2JaZVBwa2NtUCtLYTliMGtTYVo1Y0NialNv?=
 =?utf-8?B?TE1CN3A0dFZsK2tCZFFnTGtWb1RmbWpRYzIrOGlwb3kxZGNIQlV6WDhNdVZN?=
 =?utf-8?B?eTFFdVV6MFJCU0x4bk9jckc4R21qUUl6Vy9EWFZ0T3R2aWU1elFDS3o3cm1L?=
 =?utf-8?B?bGc5OE51MDV4ZkwvU3BnOTNUUnZGWGhJYkhLMk9vNjE0ZE5GZEJOTm5jWk8y?=
 =?utf-8?B?YjY3Q1NlYjVKelp5SkE4WlAzdGk3YTBmL1dQc21wL1Z5NnhHQlI0M0ZFS25V?=
 =?utf-8?B?MGxhRDNxSE5Rc0tLZUh6NlZqRGQ5Zi96ZE90MmtBa05UczBldEs5bTduU3di?=
 =?utf-8?B?Z2VPTW52cnNiTTNHSmVyazE0YjdPTTZsWEhCdEN6U3RxWjdFelhnNkIwcTFh?=
 =?utf-8?B?a2c3WTl5NUR2ZnAzZ0w2Y1poSUxjZlUvdThpRC9hcVJrcUsrQ0ZSaHNSOS90?=
 =?utf-8?B?bWM5azhKY1d3NG0rY1lZZGhOWG9TMjFJOXNaVVB1RUQ2Y0VQQmZJVXJqT2ts?=
 =?utf-8?B?dUcyQVhEWm1qOURIR1NwVnlxV1pHSjI5eWo1TnRHQzVPcFZnWGE3dzRuZmZZ?=
 =?utf-8?B?bFRKZFp2M29wWXNWRldqYkFYR3hYWU1SbFduRWUzUHRzd3BVdFVXUjRXSWxI?=
 =?utf-8?B?UHFJRDZLaTJ2TjJ5NUl0eGFNK0pyTTlPV3U4cUYyV1JMdE90SmhDWVN6bXR5?=
 =?utf-8?B?YVEzZy9OVXh0NmZObEdlOVZadlpRY0M0MmZnckdkMVVlVHpjcUZsWVBSZ0xX?=
 =?utf-8?B?dC9LdDBQc0lDSUZON1o4Qlh5TmdRTmo4MGZJZFM3ek1NdFJqK0FWbEVVNk9I?=
 =?utf-8?B?bUZDaTZ2Um5NL2dzS3J0MExTUTZlN3pURXFqOTZBb3lNYnpoeGh3am1LdXEw?=
 =?utf-8?B?VzhTSmdQS2lwd0VGVzNBRnlwZTZ5bDJzM3o3VWM2b09Ec2IvNHFtNklnMGRw?=
 =?utf-8?B?UWQ0dEpIYkFqRE05NU9PMnRyNTZLVjg4d2o3V1FWMmN0RkRkTlZURVh5MEFm?=
 =?utf-8?B?OGU0ZDd4OHo1cG85eTB2d29meFZsMUhJRTVXdjY0cGwwWEhYZTZjUUZuOU0r?=
 =?utf-8?B?ZVVkV211dStMbFNkTlViQmkvaHJWOXU1OTRQeEhtY08xOExiS2pWeE54eUly?=
 =?utf-8?B?QXZ6eHBNdUsxQlBJcHhCdy9oR3YyNHhnUHZWV2VZdkZNSm5ZTUJ5ZUFMczB6?=
 =?utf-8?B?c3VaY3V5V0QzVGcxd1ZHMERhdUF2QXNZNkNFK2o5b0dqUThqMVViV0xmQjIw?=
 =?utf-8?B?L1l6TkJhRmZPM002clRyMXdjUHkwNFZubTlmQnVXUjlML0tCWWNQRllwODFH?=
 =?utf-8?B?RlpFQmNNVUhBellDT0FKYnAzdUg3b1VXOU95WWxVUnBpVWxLTElROEE3eEVT?=
 =?utf-8?B?a0h0bWxkUThVRW1scEtBS1NQSGtCYWswejg2V1ZTeWlTc3ZJUyt4azRrL0FQ?=
 =?utf-8?B?N1l3OFZDd2dObFFPSFp1SDNlK0FJMVBJM2EydFg5eUx4N04vTm1PRlRPait1?=
 =?utf-8?B?Ym0wVUpCK05jUnZPVm52cnZCc2JPWlNBOGNCb2dVOUhYUEVFUUZzb21rRk9L?=
 =?utf-8?B?YU54bUtrMlZ1cTY4SjRmMFJWV0pwZlBRditxR2F0ZmR1SXNrRDhVZE9zSGl4?=
 =?utf-8?B?OTA5U051M1JIK0ZNM3NWVFVCZER3aXJqMU43SXRCMVliMkJHSUxOYmNTMmlw?=
 =?utf-8?B?cXpQZ3pQdGlNcjZNRXE4UlhVWVJ6Q3lJTkRJNC9sTXFFS0s5b0hkOFNwWGVI?=
 =?utf-8?B?eGpaSkI5U1ArTmdrR2hHUUhuQXhxVFN6NGF2SUJ0WTNTeERkTWJVOW12TDE4?=
 =?utf-8?B?WlZHT0o1QWQxcnZldWJ0enhJUlN4UjFWVTRVWnpkdHdhNlZvbVdTd1ExVkt2?=
 =?utf-8?B?aUV6UzhzSUpQSkNTVHNnY1FKSFdxYWw3WnZUenFzUWpmcGsxQkIxU2JYM09t?=
 =?utf-8?B?Q2g5NllZVmRGbm5qeVNKWWtOVWV0eU56RVBYaWZPYnFCVmdVRmtXMVJ5eStZ?=
 =?utf-8?B?SU91QUplb3FDbG1KU1NWYm5UZmk1aUxkSW5XV3FsWDRCYXZLVnV5UWtvQ0pp?=
 =?utf-8?Q?T9qgMblmGcz8sTOPDC6sxMDz1?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e33ddab-7f25-412c-0913-08db530e426f
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 17:28:11.4156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qfr3UuYjSZ9vaW8E1M90CzJWF5K8Bk8qxn4yzM/TG1Sseg0nIrlRRieGvleqdBej65lUvJDRY7UPfMuyX5ydLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR08MB6834
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomas,

On Fri, May 12, 2023 at 06:55:08PM +0200, Tomáš Mudruňka wrote:
> > So this is still racy, isn't it? The interrupt may come after read is
> > done, but before we register the handler.
> 
> Well. It is. But please see the rest of the thread, where we've
> already discussed this.
> 
> Every time the interrupt handler runs, the interrupt is disabled and
> then reenabled after i2c communication is done. Which means this exact
> thing happens on each keypress anyway. So i don't think it's a
> necessarily huge deal. It might not be perfect solution, but it makes
> things much better. window in which the deadlock condition can happen
> is now in range of few ms (or us), instead of ~10 seconds (previously
> it included bootloader and basicaly any moment from power up to driver
> load)

Right, but the point is that there are some alternatives to reduce the
range to zero. You posted one already, but I mistakenly advised against
it due to my own oversight :)

> 
> Another solution would be to trigger on LOW instead of FALLING as
> proposed in initial version of the patch. That would be safer in terms
> of lm8333 deadlock, but Jeff was concerned about possibility of
> interrupt storm taking down whole system in case the IRQ line gets
> stuck in LOW for some reason...

Just to clarify, this is not my concern; all bets are off in case of
gross hardware failure such as this. Rather, my recommendations are:

1. Level (or edge) sensitivity should be specified in dts, not hard-coded
in the driver.

2. If you open support for level-triggered interrupts, you should verify
on a scope whether there is any chance that the IRQ line may still be in
the process of rising at the moment the read is completed. The datasheet
is ambiguous here.

> 
> Tom
> 
> pá 12. 5. 2023 v 1:44 odesílatel Dmitry Torokhov
> <dmitry.torokhov@gmail.com> napsal:
> >
> > On Wed, May 03, 2023 at 08:44:06PM -0500, Jeff LaBundy wrote:
> > > Hi Tomas,
> > >
> > > On Wed, May 03, 2023 at 05:32:31PM +0200, Tomas Mudrunka wrote:
> > > > LM8333 uses gpio interrupt line which is triggered by falling edge.
> > > > When button is pressed before driver is loaded,
> > > > driver will miss the edge and never respond again.
> > > > To fix this we run the interrupt handler before registering IRQ
> > > > to clear the interrupt via i2c command.
> > > >
> > > > Signed-off-by: Tomas Mudrunka <tomas.mudrunka@gmail.com>
> > > > ---
> > >
> > > Reviewed-by: Jeff LaBundy <jeff@labundy.com>
> > >
> > > >  drivers/input/keyboard/lm8333.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/drivers/input/keyboard/lm8333.c b/drivers/input/keyboard/lm8333.c
> > > > index 7457c3220..52108c370 100644
> > > > --- a/drivers/input/keyboard/lm8333.c
> > > > +++ b/drivers/input/keyboard/lm8333.c
> > > > @@ -178,6 +178,8 @@ static int lm8333_probe(struct i2c_client *client)
> > > >                     dev_warn(&client->dev, "Unable to set active time\n");
> > > >     }
> > > >
> > > > +   lm8333_irq_thread(client->irq, lm8333);
> >
> > So this is still racy, isn't it? The interrupt may come after read is
> > done, but before we register the handler.
> >
> > > > +
> > > >     err = request_threaded_irq(client->irq, NULL, lm8333_irq_thread,
> > > >                                IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> > > >                                "lm8333", lm8333);
> > > > --
> > > > 2.40.1
> > >
> >
> > Thanks.
> >
> > --
> > Dmitry

Kind regards,
Jeff LaBundy
