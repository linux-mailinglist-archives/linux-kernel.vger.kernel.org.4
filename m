Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC9A748416
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 14:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjGEMWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 08:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjGEMWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 08:22:18 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452C21709;
        Wed,  5 Jul 2023 05:22:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/aggQueKs7f86fpA/UiOPjbr1jErmGccTFFOz2rYa35hoC4YOZtINn2iYzCd71FHdY9MoueJ+WYzRN3gs+jhzA2nYto9eaJo4kPyKccmDVmQHNQxrxAOSzTBz4O5hPgOcKPuJVxQ4KArmjQZv5t/KbyttBIUROc5WxnpzUXXZMO9R2oz2MdqHINWDlTgh+2JTs9YATB8+t8vxWZQbDsyG5+nkuZzUP4QY6vEIHbo7zbzuOEck6VLluz9VgW9ukM4vnNYT/dv6wnKh3Edo6ggF1f+vijf6O8x8ooK7MHUGPCQNlOUE8JFMGiwn4VRT5WxozhxR9FnVCWPuBVeiGKhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C90Yz2WFZWyaa1otZWqkKOE1JDv4gQvmiiqhkK9C+BA=;
 b=M1FU13V4r9wkQPOpyysQ0/YufYlit5UnZQZ8cVZOnrAQXqXT1qouUXqcF2NTD4JJ0vNVCbiRkqIb5Fh/e3J2mtvOjnpEUvfOIeL9XZtPUz9rflUC6NByqFHQhv6R2ndEtdNQYS6Myfox2Sjo7/hb/1SExn/CLk0kIDh/NqBx8NBZNAurq2MK7i+76q+P1V4fPT5cxn6//pEFJGNs7PEwf1qt6i47sA/fZ5zZ42fAkGByO6EGHXlkN/OdTX8V1n/I52y/dr2jXOpOXqp0/Af2758HeFdEfwgEnG/MKwBdInUOXEP9DpRvhy2CpfYKCfidlhyvolk5UCG+Efvi4oTFkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C90Yz2WFZWyaa1otZWqkKOE1JDv4gQvmiiqhkK9C+BA=;
 b=xhMIQACrMw2RUa+aZZ0pDhJ9odhJyMSQMSe4zoKnu5I8zaZ5rmghfQYnwGGNSeBXU4Zjypey9fvQtXgmviUAcQhg42VBVWldWYHs9Azix3BHbs6vSE69tUBIygDyMCvkBbr1Sx0dQUyqLHDc9hOUwj+F8SBvPzDLIWI0mcTKlF2HraglZUtVlZk9n+8/xb/0fq6ppckjjpC9o6TSvfBKiln/jLVF6rvlxxk06XPoZU6cMZvo1PQV9ez6SPmuYqx1Yh1n9Pf7Qfta6bikTN8wTJ04d2lIKgdiMhNLXGfYqJ6PnYujOwFPH7KxuGNxM9QfTaHio3B8OGgcYxtC+MqvpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
 by PA4PR04MB8000.eurprd04.prod.outlook.com (2603:10a6:102:c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 12:22:14 +0000
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::637f:a940:d807:34c2]) by DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::637f:a940:d807:34c2%2]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 12:22:14 +0000
Date:   Wed, 5 Jul 2023 20:21:59 +0800
From:   joeyli <jlee@suse.com>
To:     Weiteng Chen <wchen130@ucr.edu>, Yu Hao <yhao016@ucr.edu>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: How to reproduce the BUG general protection fault in
 hci_uart_tty_ioctl?
Message-ID: <20230705122159.GA26742@linux-691t>
References: <20230628150140.GU21539@linux-l9pv.suse>
 <CA+UBctDPEvHdkHMwD340=n02rh+jNRJNNQ5LBZNA+Wm4Keh2ow@mail.gmail.com>
 <20230704030131.GY5866@linux-l9pv.suse>
 <191B9131-6E47-49B6-8089-108E2B12B9DC@ucr.edu>
 <20230705084148.GK5866@linux-l9pv.suse>
 <20230705093636.GL5866@linux-l9pv.suse>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230705093636.GL5866@linux-l9pv.suse>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: TYCP286CA0095.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::18) To DB8PR04MB7164.eurprd04.prod.outlook.com
 (2603:10a6:10:129::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7164:EE_|PA4PR04MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: 189316cb-9de6-44c0-4c9e-08db7d52751e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3OD+Ye4pyGaUvg4CtKe0iP49wWg/yw5J5NWsCU2PxEk/dM9TS/5gHnEP3b2GFWb/SpxGsb+RZfwOztzJy139F1AaLSchOOl71q9qJ3Y28sF7kCY65nvN3Gg6+2lwvidWRMEoxmxs3iR4Qjpqs+SbYA+G6y5k0i6qTFX7EkqygjD7i+poiZURQ+iyOWCV0LBAdFr0kN0AuVqSYWZc2W3koGCLJocPO3FARS9oUuzms4uvLjZcF8YVF7EfRa3DTZEFP7WrVAUQUrF+mjyMHC4OmM14qJ7YApK87K6y+EwodvjmYNjCseU9Mo0iaKMtcN+5c1Awa/KAQfhwfPLSusuC4OQ9ngp4x+9ZbJAXaics2Lh0Ekv5D2SFsM/pfzRJ0kEjR0rMmcbK4IEpXaAdktTxbNIcf/saPxiwRMmGSAZ6bUUzgDkUkYk5nbpNU+4klaz9xE2oq7tNkeIdZo80nErHhcoLye8TLxK5xFCBUlu7wJHo31yTUTy8RQ0QX+G0Lra122tuXPCbOoDo9pzwVI2pY3R/A1wz7/CMYDDWkDo3DT4iqtWI55IYjgRoZUH66AkCpuFOIk7M90KSuR6JU+/41Fz4810XtYCijFjA4Ks2OaQy8ZZZKI8st5OSYKq7JglROiqgPujkf9PJgNEIXRFM8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7164.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199021)(41300700001)(2906002)(5660300002)(8676002)(8936002)(33716001)(33656002)(86362001)(6666004)(478600001)(186003)(9686003)(53546011)(26005)(1076003)(6506007)(6512007)(966005)(6486002)(4326008)(66476007)(66946007)(84970400001)(66556008)(316002)(110136005)(38100700002)(83380400001)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEliNWZQZzNkSjJrTU9FaENtVWEvRm9nc0JLVi92N0IweWZBbzN3Tk5UamJZ?=
 =?utf-8?B?TWVxT3crUGNNeGNIaG5keXNwcDNrT250VG1GeVlMaENtWGVnbXI1ZkQ5cVBy?=
 =?utf-8?B?bTFJblFYbWovK05YeXJrY09wbFhVMFB6bGVFWHlwVVFSSzd2MXdFcWM0MnR4?=
 =?utf-8?B?azQ2M2xqQlcyUCtGUzRNZUJlOElWb0RQODl1TndJUjI2NGQ1MFpmcFVLL2dK?=
 =?utf-8?B?cHhYdWFrK2ovUFhoTGZUQ1pubG54WEVzazhBSlJsV3VqcFh4VGVpSCtxTkRa?=
 =?utf-8?B?Yk8wSXQybXppQnJNay9qTDh0OFFoOGYvbFY4M2FWaDk1R3JrUzZjaWFHUm5G?=
 =?utf-8?B?MXRJeFJ3T2VtcENiYml4blRTWnYycWkvbis1RGlHaVVZbDd6dWw3bHV3bVVO?=
 =?utf-8?B?alozVHc4ZmdqSElaSEM2QkJLOGpBak9qV1d6T2hNTHpsVXNxYkgvQVRxMUtk?=
 =?utf-8?B?ZEhycVlxUlE0T0NnamV1QzE0OTAxck5EQ0NzWVZ3RWRCL1c3YjBCYkx2UmNx?=
 =?utf-8?B?TGZjNTM5VnQrVnlxcTdLY25XcEhLWXhSR1lMaHZFMFZpWW9oSDVXNGQ3dFhv?=
 =?utf-8?B?SHhmQjRWVTFadjk2N05kM0V6ejhpd1B1YzdWY0hweHhFWkwvUnpRbHNTb2Jw?=
 =?utf-8?B?TVV2Z0IxUm5BeW1qbklYWTVGeFBZazNUWFQ0V1pGK2RhWG4xU0NYU0xnSmF1?=
 =?utf-8?B?cnZ6bjNXQzhKOUVOc2hTVVZhdGkzUFpuS01DZ1dQYU54R3ZNd1hja01oYzI0?=
 =?utf-8?B?M1FMaUZjcWt2UkJvL05ZcVIwNUVWb1VDSlpqQndveG96N1AvQXZ3dVA2NXp2?=
 =?utf-8?B?T3V6YXBQU0plTDRnekdza29GczFRSGp2MDdZaHpjNlQ2QWhYeW1JL0p3MDl0?=
 =?utf-8?B?VXBxd3J2c0hCNkkyeitxck4wcEtrMVdaOWxJWS80by9qUnhDalBtNDdOeGVs?=
 =?utf-8?B?YklDNFdBV0VEa0trSnNYaGFXRVYrci9DV29mcnlTZlVKL240YVVwekZPQy9P?=
 =?utf-8?B?UUplWWk1NlpxdWpVT1NpMkVEVTZNYjVSQkI2YXIzWkVITjd3REVWeGszS3BY?=
 =?utf-8?B?WjFZRkV4dUgrTkZQRTFQbVRDVDlzSTd4MmpxdUV0a09lT2lJNkVkeXB5SDBK?=
 =?utf-8?B?R1YxMGxBSGEwWFNYOVVYMnRtd2xhNTVlZFFVNGo3YW9Lbm5abVp1bElYVnBu?=
 =?utf-8?B?WWtCK3FGWnpyNkFEcXRGNmlrQkJhZlExVkFDYnBRV21EaXVMQXhscGJFSk5s?=
 =?utf-8?B?UXNDclRZSDFweXFYQy9MSkJvZFJqQTRsa2M1c29GaGVweWFaaDh5WTFSVGJF?=
 =?utf-8?B?b1lrLzFUQW9WMU1PVVNkZUtWaCtZZVJlZndKUjJVU2FoRjVFUGErbldPZk44?=
 =?utf-8?B?SmFzMzh2VzVCZHgyY004WXZ3azM0MkZQaWVLbUR5UUV3Y3c0RHFaSnJQZmlC?=
 =?utf-8?B?M0xyVmxrZGIwdlBmb1FhNWtSRlJXWmZNR25aTm43QXdpS2tYSUtGWFhROTJ6?=
 =?utf-8?B?R2Z5NGZDN0ZFaWlIMmIyT1RoTDd4anF0NDEzWEVXaW1mbDdWaEIxbHczOC9o?=
 =?utf-8?B?aFpKMWxnb2d3Y05ycW03RDI5TGJ5MWlGR01mZlFsYjhNRXAyM3Z5VlNVQ0wz?=
 =?utf-8?B?UUk4cm9VZmhRR2huZDdnMkx0V0ZaNkVrbGRoZkNKVXBnd1NrVWFRUDAxeHlu?=
 =?utf-8?B?elNaMiszcHpuNnZSWXdrQkJKSmxpOWFuNXAwMlQ1WW42SHE4djdtb3JoVzcx?=
 =?utf-8?B?STUzRlRlTEtGZE4yZzFjWGljSEJCaFV1bWY2WFBSM2wwblJrMm5lYWVGTkpT?=
 =?utf-8?B?QlozU1ZqaTdhb054WEhwZXNkSmJzRjhMNmVxRDYxNjU3Z2lBamw2aDVTK0RT?=
 =?utf-8?B?SVRRM1ZZVVBWOGt5b0lSd0E2Vnl0NmYxQk1aMnYrMDJ0ZkpXTWp0VEZ2d09G?=
 =?utf-8?B?V3A4MEVTQ0ZteFZRS3ByUW9jd1NVajhSNmlUTmtjZXcvMmZFbDhQSjRkQm1m?=
 =?utf-8?B?b2FDODV0S2ZpZklIRytVTlptUy9vVkJ3UU0rN3Q4N1ZXa1o4ZkZla2M4Y1N5?=
 =?utf-8?B?Q2xMdFpVUlVDa2VJV0dwZEh4dHhoSWxhTUlsSGhXUUJDWFJWQkcxWlNiVDlX?=
 =?utf-8?Q?CS7Q=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 189316cb-9de6-44c0-4c9e-08db7d52751e
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7164.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 12:22:13.7851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fq5ZGO2ntfU9OeCSk+ez7/S4dbrqYkoD2nRfJAKQlpVFONGhUPgWLf0PZoGgDyNy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8000
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 05:36:36PM +0800, joeyli wrote:
> On Wed, Jul 05, 2023 at 04:41:48PM +0800, joeyli wrote:
> > Hi Weiteng Chen, Yu Hao, 
> > 
> > On Mon, Jul 03, 2023 at 09:07:38PM -0700, Weiteng Chen wrote:
> > > Hi Joey,
> > > 
> > > Sorry for my late response.
> > > 
> > > https://elixir.bootlin.com/linux/v6.3-rc7/source/drivers/bluetooth/hci_ldisc.c#L764
> > > 
> > > switch (cmd) {
> > >         case HCIUARTSETPROTO:
> > >                 if (!test_and_set_bit(HCI_UART_PROTO_SET, &hu->flags)) {
> > >                         printk(“test_and_set_bit…”) // insert a prink to make the race easy to trigger
> > >                         err = hci_uart_set_proto(hu, arg);
> > >                         if (err)
> > >                                 clear_bit(HCI_UART_PROTO_SET, &hu->flags);
> > >                 } else
> > >                         err = -EBUSY;
> > >                 break;
> > > 
> > >         case HCIUARTGETPROTO:
> > >                 if (test_bit(HCI_UART_PROTO_SET, &hu->flags))
> > >                         err = hu->proto->id;  ←- null pointer deference
> > >                 else
> > >                         err = -EUNATCH;
> > >                 break;
> > > 
> > > This is a race condition between HCIUARTSETPROTO and HCIUARTGETPROTO. HCI_UART_PROTO_SET is set before hu->proto is set and thus it may dereference a null pointer.
> > > 
> > > To easily trigger this bug, I inserted a prink in the source code so that the C producer can easily trigger the bug. Please let me know if you have any questions.
> > > 
> > 
> > Thanks! I can reproduce the issue now. 
> > 
> > Weiteng, Yu Hao, do you have plan for sending patch to fix this problem?
> > 
> > Joey Lee
> 
> Looks that check HCI_UART_PROTO_READY is enough to avoid problem:
> 
> --- linux.orig/drivers/bluetooth/hci_ldisc.c
> +++ linux/drivers/bluetooth/hci_ldisc.c
> @@ -771,7 +771,7 @@ static int hci_uart_tty_ioctl(struct tty
>                 break;
>  
>         case HCIUARTGETPROTO:
> -               if (test_bit(HCI_UART_PROTO_SET, &hu->flags))
> +               if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
>                         err = hu->proto->id;
>                 else
>                         err = -EUNATCH;
> 
> If you do not have plan to send patch, then I will send the above change.
> 

Updated patch. The HCI_UART_PROTO_SET should still be checked with
HCI_UART_PROTO_READY:

--- linux.orig/drivers/bluetooth/hci_ldisc.c
+++ linux/drivers/bluetooth/hci_ldisc.c
@@ -771,7 +771,8 @@ static int hci_uart_tty_ioctl(struct tty
                break;
 
        case HCIUARTGETPROTO:
-               if (test_bit(HCI_UART_PROTO_SET, &hu->flags))
+               if (test_bit(HCI_UART_PROTO_SET, &hu->flags) &&
+                   test_bit(HCI_UART_PROTO_READY, &hu->flags))
                        err = hu->proto->id;
                else
                        err = -EUNATCH;

I have tested this patch a couple of hours. I didn't reproduce
issue.

Regards
Joey Lee

> > 
> > 
> > > Best,
> > > Weiteng Chen
> > > 
> > > > On Jul 3, 2023, at 8:01 PM, joeyli <jlee@suse.com> wrote:
> > > > 
> > > > Hi,
> > > > 
> > > > On Wed, Jun 28, 2023 at 06:57:47PM -0700, Yu Hao wrote:
> > > >> Hi Weiteng,
> > > >> 
> > > >> Could you give more info about the bug, e.g., kernel configuration,
> > > >> qemu arguments.
> > > >> 
> > > > 
> > > > Base on kernel code, looks that the HCIUARTSETPROTO and HCIUARTGETPROTO
> > > > blocks in hci_uart_tty_ioctl() should use hci_uart->proto_lock. 
> > > > 
> > > > I have run the C reproducer a couple of days in qemu, but it did not
> > > > reproduce issue until now.
> > > > 
> > > > Does anyone know how to reproduce this issue easily?
> > > > 
> > > > Thanks
> > > > Joey Lee
> > > >> 
> > > >> On Wed, Jun 28, 2023 at 8:02 AM joeyli <jlee@suse.com> wrote:
> > > >>> 
> > > >>> Hi Yu Hao,
> > > >>> 
> > > >>> I am looking at your "BUG: general protection fault in hci_uart_tty_ioctl":
> > > >>> 
> > > >>> https://lore.kernel.org/all/CA+UBctC3p49aTgzbVgkSZ2+TQcqq4fPDO7yZitFT5uBPDeCO2g@mail.gmail.com/
> > > >>> 
> > > >>> I am trying the C reproducer in your URL, but it is not success yet:
> > > >>> https://gist.github.com/ZHYfeng/a3e3ff2bdfea5ed5de5475f0b54d55cb
> > > >>> 
> > > >>> I am using v6.2 mainline kernel to run the C reproducer.
> > > >>> 
> > > >>> Could you please provide suggestions for how to reproduce this issue?
> > > >>> And what is your qemu environment for reproducing issue?
> > > >>> 
> > > >>> Thanks a lot!
> > > >>> Joey Lee
