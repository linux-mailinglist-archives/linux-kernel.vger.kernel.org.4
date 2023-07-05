Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D5C74810D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 11:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjGEJg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 05:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbjGEJgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 05:36:53 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2059.outbound.protection.outlook.com [40.107.8.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605E3173E;
        Wed,  5 Jul 2023 02:36:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrTW1xMjgiQeKjolG+Dlun+/qW8TkBZZ6ZswVsgQAcoN35p7db/KFGJsSOUkausVH3JOsLZ3cLj46DDnX5eSHmGib0gK0FZXkglodI/On+1AXVaJ4kq03UNzvqI0jyE29fA8rXoz83f0hISU+CROqICfb7MfjohEtTxjxjwRCVCJ/NfPQNcPeyCMWdOhzxJXnINe6oPLxS4SlWmsEC/6knJZ5EvT37E7con7k4CKoVjJu1C9onQ/lilhPKUK9LzlWy2QqJ70jQt8oKLneCI55nf+gaOUCbis7QqAlXji+9r8/T7herzzAMQ6+FZDHnELgFFTsRuZddE5/PQdX3FkxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFnspkMdQ0unIXE4rJ2K2f3czgHjMZojJCCiJUPqeqk=;
 b=oRTapCBQ7zyaCAClFHvFnwRf3L5yjRkTEgVuvhoUzmGDQTU7yewM4Vfr9JGbIXYuICuPLcAWRQFugaA6rdY2NhCCHIS+ZdHpZ28ZrhfG2T0A8A+BMUSc7JBUQP8VIus4Se6KPOAweLny7sYJrleOHlfCxFjivEbTrG2xzuLSV7nuLF+AL04zhhQBx6UcH4Isjbk9iUNQ4TVIOkKDKIZePDCWTh2lEtzH8M2/MtPqMdqwIOhUiET0X+hi3j8X5SMGGR2DoLKMLPH0TOa0rKa6YgFMitJXuL8PEEc8C+O+34+BuOPOBHoaaAy2LBId9InMHAeMULzAwlviBkQYr/42RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFnspkMdQ0unIXE4rJ2K2f3czgHjMZojJCCiJUPqeqk=;
 b=Ig/Aziu90AMW5DFOryCE4Bq/+X2jm/yuPI8Jo8AoiTGogYLEqJrWQggwrg5wpmShB8YDR9hDkz4iTx7UsjruRnTKG30LQlvrwHhDML18P6sgUMAi2Gw61VrxpyedBN1um4f75af/KDU5orcbDC0BhsP9sd6DfxXFdw0pmANFs1Wf5YH5sB22oRqlVQz32dncoemE46dU2ZAmWJjphcJWo87j4gvYIE/WQZnPlGEpV7LYlglra8Mbd44AULizggBFOnh9wt6C2KMVOwHgasb5LngjTEdURh622nOg5PPnyinXjJi4TLI33mcodbsCOia65HhIlQrZrZV6pKqpsV/oCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
 by AS4PR04MB9623.eurprd04.prod.outlook.com (2603:10a6:20b:4cd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 09:36:48 +0000
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::637f:a940:d807:34c2]) by DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::637f:a940:d807:34c2%2]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 09:36:48 +0000
Date:   Wed, 5 Jul 2023 17:36:36 +0800
From:   joeyli <jlee@suse.com>
To:     Weiteng Chen <wchen130@ucr.edu>, Yu Hao <yhao016@ucr.edu>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: How to reproduce the BUG general protection fault in
 hci_uart_tty_ioctl?
Message-ID: <20230705093636.GL5866@linux-l9pv.suse>
References: <20230628150140.GU21539@linux-l9pv.suse>
 <CA+UBctDPEvHdkHMwD340=n02rh+jNRJNNQ5LBZNA+Wm4Keh2ow@mail.gmail.com>
 <20230704030131.GY5866@linux-l9pv.suse>
 <191B9131-6E47-49B6-8089-108E2B12B9DC@ucr.edu>
 <20230705084148.GK5866@linux-l9pv.suse>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230705084148.GK5866@linux-l9pv.suse>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: TYWP286CA0009.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::7) To DB8PR04MB7164.eurprd04.prod.outlook.com
 (2603:10a6:10:129::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7164:EE_|AS4PR04MB9623:EE_
X-MS-Office365-Filtering-Correlation-Id: fef5162d-8889-4156-8d05-08db7d3b5aff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zDDSQedcGJbvVtlPRw7DrTnmzZiBATUIg/E0BXrf+jtAnZwR3hzEkOUAx10zFDaLg3zwGe2IVz8J9c9AgqEenBfbjX8x52j7yiL6sTIYTNGdafpQ+C1VpavScj1Kbc+Nyeqg9R2SWHT0IIGX9+MIn2vSjqpeV0dWovr/h1c3SXspMmpal39BY11Nit0tIh5trzbNFYQwCSEFMMsMAgOwTFVaHSOa70jec/TmOIG4Ebka8tJbxaa5fiyt+lbUEmDm9GzrKdOlF+XUtspLInafTD4w6EQJQo5DICrM9pySvLWgpLEEGfJwRsPuuo2LQRYd5DD1t8jT/JDu0/ntUjeIV40GMWeVtl+QVzAhSl0u51y6HlrL0ZH25FRnWcISZndU9Y7x4bFbXg8Lkf4BZ/h6QlqkEYL3PFsBfygBNCTxfHBdl8baD5ApqvoK198VyeJYo4E5onPag0JMweFGXNwTSAO3HP8KFGTEawZX62lqt9ZYun3x08NHP2/djl6EAl3I2k3L5einMtnzWhK1sQXup2Vs1fe3TsIbp/qrHbi8q7k3fGFnzo4iZtiet7u4d1aP90/MevrRwYEtHIvQGzbvfrwoD9ut93OptR4YkAb2l4uPf4f1aTiI5HWSzgOLVVZUAhLsd+6b4OnESF7Mje5eow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7164.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199021)(8936002)(53546011)(5660300002)(8676002)(86362001)(38100700002)(83380400001)(41300700001)(316002)(66556008)(66476007)(36756003)(4326008)(66946007)(966005)(186003)(9686003)(6512007)(33656002)(26005)(478600001)(110136005)(6666004)(1076003)(6486002)(6506007)(2906002)(84970400001)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2cyb1Nid21zMkpLZVEzMStONmxFa1dySnV3QkFSR1VVdGVXandZdEcrL1Ir?=
 =?utf-8?B?SDNHbVpEd2JKWUtJOXZYbWkycDN5c0wvckQzVUhSNi9oTTF2eUtTQkpOd0ZQ?=
 =?utf-8?B?ckR3cGlFL1JzZ2MxMjhWL05XdnVkREowRVFmSmF1dk1FeXhSbGZTU0E1YTNG?=
 =?utf-8?B?WDRyYnhGUWFkSW14aE1ER0RDRmxwOExoUUVmdHlMZDFkL1Q4aUZKQ2UreWVE?=
 =?utf-8?B?TVZBM1llaTg2UlUxVHhhTU5qQ3RETTYyak9lY0IwOHZYc09OTCttSGdFRXI4?=
 =?utf-8?B?WEpoWUVQTUhIQjRIc2V3NUJoMEFxeWhYS3U2UHNmcUxQWGNjT1RiUFR0MjNx?=
 =?utf-8?B?RHRGQ003NHVieEIxL29ldWE4bGcyb2FKdms4d1hmWUtnVTBhckRxcnBvcmJL?=
 =?utf-8?B?eGgxVkp1Q0YwL3hFQ3VLUTJBZ3hNWlRRc21OV2tBdnhESGlPMFVnaWFNd1JX?=
 =?utf-8?B?amcvU2hBM3NzbUlORG8wcGs5Sk9tcEVkcEZBSksvaDdVdzBaSEx6MGlMNktS?=
 =?utf-8?B?RG1sN0xrV3lwRGtzK1ZTbXkwcmxwU2dXSDErNEI2RUMzaUJlaWVBbUxQcTA2?=
 =?utf-8?B?aW9ManVQT29HQW5MQ2NDTU9FMWUvanM0VkNFYVFSV3pHR3QzYlpzeVNRTUpM?=
 =?utf-8?B?TWZqcUlybytVak9GaHZndVROOWIwTUNlNWhmZHlxeGZHV1AvMWcrcklpNU5B?=
 =?utf-8?B?R1hxLy9kcWdaOU5jaHpsNEI2ek15bHJTRkZiK2dRMlhHMnpLajUwQnV2b2Vw?=
 =?utf-8?B?SHZ0THdYVFNvbGNkMiswaHpla3JJbk5ZVVJWYWlQb21oL2I1bnV5SEtkLzZP?=
 =?utf-8?B?NVVOcE9sUlpMc1VqWWJIY1NEbHNiaW1OVHI5cTJhL0Z5RHBBaGZpNE1uL0ZG?=
 =?utf-8?B?SkpYUmZFRnBYTjRYRTYwTGRPRVZWalNmeTlCekNaWCs3NWNWVzF1SCtRdGdK?=
 =?utf-8?B?eTd4U21zaGZNb1pHamZGZmdqYVc4M3c5K25ZT0hvY1RXNXpibklKZlVTbTFO?=
 =?utf-8?B?MXJkMXM2UnVYV2xBQklRUkpXd21FbGZFVm8zZFhDQkx6NWRXL2NpdjhNSmMz?=
 =?utf-8?B?RDlQb2dLY0t0cWxBZDRlRlVGTzhoZWczcHFZaHMrakFGVnRVUFloSUtPQnZt?=
 =?utf-8?B?TWpwODVQSlJRcWVXVi80OUg1REh5eFJvM3VwbDd2L3NqdC8vZnBqUElBcy9I?=
 =?utf-8?B?ZSt0SnBRR3JLKy9DV3FpdHpDQmR1ZG5QNzVCQkNMTmtRR3FWZWxyUlB4K2M5?=
 =?utf-8?B?aXUyeWhlNW51bUgrWlA0TVp5WEhpNVBycGtUY244VklBbTBlcUN3MnNUQlBL?=
 =?utf-8?B?cXpNckZneWFERmxrYStCTG9ESVUzZFZkNVI1ZXVRTjRHdG5ULzRmbGMvL0Qw?=
 =?utf-8?B?NUgvdXBmR2thYVRnNUlqczhDNzVzRkdNbmp6d09HSnZ2NStDSFRhczBzaW1K?=
 =?utf-8?B?L0hhRGVnMDdpeC9vRXBkQnhLNzNUNllsTHphRWJ4T29zTnhjTkozamRETE1y?=
 =?utf-8?B?Q2txWFBCdDFXWlJnTFhkbk5XNHpsWVlZSUNSVGMyUnBPUUdPRHErUEI1b3Y4?=
 =?utf-8?B?SHEwMy9wWlh3cDdzRWs3TmF6YzhKaDV2UHRQeDcvak8zQnFtcVR3REJoTHJY?=
 =?utf-8?B?T0dQRlUzWGRRSUlkTkY0RkMvaFJNOUVjaWJpQkZ1RW9vZFV2eHduRE9LWkVl?=
 =?utf-8?B?Tm81NVplLzFtZUUrZC9HeE1pVDUxcVlCaEQ5RlNNbnRQVjg2Z2FUaEgyUURj?=
 =?utf-8?B?MGUxYi81eHRiSjNtem1aQ0xWWVBJSEMyZnZOMUZSWnZVY2kva0sxZDU2NURL?=
 =?utf-8?B?S2t6SGU1RUlmbm5IRDhpUG93ZGhmenJqVFdCeDFraWVKMjBQM0dKbU5hTUJH?=
 =?utf-8?B?RHRDaXNUcXFDVjBHc2dJME5aeDVKZStkRjRCTmdTQUxUN1ZTT0RDNDc2OXF3?=
 =?utf-8?B?SitrUTg4ZUNoS3ZsQTBBRW54bndhQS8xemdlbkpxMGNmUjgvU1pUUXFUcGxu?=
 =?utf-8?B?WGVnSUN0blJBZ3BXY0g5aG9FS0dLalo0TmJvZ2NiWWcvUWI0a3QxN2Z6eXJa?=
 =?utf-8?B?ckRkV1ZjT2RwY3V0TG01V3Vkb0RXTzl5aUtGRXFYZEdGTGlPVmk5V0xEODJJ?=
 =?utf-8?Q?HCpE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fef5162d-8889-4156-8d05-08db7d3b5aff
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7164.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 09:36:48.7433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0/BPSip4EGYdZeNH3IZQcJiIC+fQxVfpuFZHb3rFslIc/tCR0tStZdbz086NNSI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9623
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 04:41:48PM +0800, joeyli wrote:
> Hi Weiteng Chen, Yu Hao, 
> 
> On Mon, Jul 03, 2023 at 09:07:38PM -0700, Weiteng Chen wrote:
> > Hi Joey,
> > 
> > Sorry for my late response.
> > 
> > https://elixir.bootlin.com/linux/v6.3-rc7/source/drivers/bluetooth/hci_ldisc.c#L764
> > 
> > switch (cmd) {
> >         case HCIUARTSETPROTO:
> >                 if (!test_and_set_bit(HCI_UART_PROTO_SET, &hu->flags)) {
> >                         printk(“test_and_set_bit…”) // insert a prink to make the race easy to trigger
> >                         err = hci_uart_set_proto(hu, arg);
> >                         if (err)
> >                                 clear_bit(HCI_UART_PROTO_SET, &hu->flags);
> >                 } else
> >                         err = -EBUSY;
> >                 break;
> > 
> >         case HCIUARTGETPROTO:
> >                 if (test_bit(HCI_UART_PROTO_SET, &hu->flags))
> >                         err = hu->proto->id;  ←- null pointer deference
> >                 else
> >                         err = -EUNATCH;
> >                 break;
> > 
> > This is a race condition between HCIUARTSETPROTO and HCIUARTGETPROTO. HCI_UART_PROTO_SET is set before hu->proto is set and thus it may dereference a null pointer.
> > 
> > To easily trigger this bug, I inserted a prink in the source code so that the C producer can easily trigger the bug. Please let me know if you have any questions.
> > 
> 
> Thanks! I can reproduce the issue now. 
> 
> Weiteng, Yu Hao, do you have plan for sending patch to fix this problem?
> 
> Joey Lee

Looks that check HCI_UART_PROTO_READY is enough to avoid problem:

--- linux.orig/drivers/bluetooth/hci_ldisc.c
+++ linux/drivers/bluetooth/hci_ldisc.c
@@ -771,7 +771,7 @@ static int hci_uart_tty_ioctl(struct tty
                break;
 
        case HCIUARTGETPROTO:
-               if (test_bit(HCI_UART_PROTO_SET, &hu->flags))
+               if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
                        err = hu->proto->id;
                else
                        err = -EUNATCH;

If you do not have plan to send patch, then I will send the above change.

Thanks
Joey Lee

> 
> 
> > Best,
> > Weiteng Chen
> > 
> > > On Jul 3, 2023, at 8:01 PM, joeyli <jlee@suse.com> wrote:
> > > 
> > > Hi,
> > > 
> > > On Wed, Jun 28, 2023 at 06:57:47PM -0700, Yu Hao wrote:
> > >> Hi Weiteng,
> > >> 
> > >> Could you give more info about the bug, e.g., kernel configuration,
> > >> qemu arguments.
> > >> 
> > > 
> > > Base on kernel code, looks that the HCIUARTSETPROTO and HCIUARTGETPROTO
> > > blocks in hci_uart_tty_ioctl() should use hci_uart->proto_lock. 
> > > 
> > > I have run the C reproducer a couple of days in qemu, but it did not
> > > reproduce issue until now.
> > > 
> > > Does anyone know how to reproduce this issue easily?
> > > 
> > > Thanks
> > > Joey Lee
> > >> 
> > >> On Wed, Jun 28, 2023 at 8:02 AM joeyli <jlee@suse.com> wrote:
> > >>> 
> > >>> Hi Yu Hao,
> > >>> 
> > >>> I am looking at your "BUG: general protection fault in hci_uart_tty_ioctl":
> > >>> 
> > >>> https://lore.kernel.org/all/CA+UBctC3p49aTgzbVgkSZ2+TQcqq4fPDO7yZitFT5uBPDeCO2g@mail.gmail.com/
> > >>> 
> > >>> I am trying the C reproducer in your URL, but it is not success yet:
> > >>> https://gist.github.com/ZHYfeng/a3e3ff2bdfea5ed5de5475f0b54d55cb
> > >>> 
> > >>> I am using v6.2 mainline kernel to run the C reproducer.
> > >>> 
> > >>> Could you please provide suggestions for how to reproduce this issue?
> > >>> And what is your qemu environment for reproducing issue?
> > >>> 
> > >>> Thanks a lot!
> > >>> Joey Lee
