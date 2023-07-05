Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506C3747FF1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjGEImT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 04:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjGEImN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:42:13 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2043.outbound.protection.outlook.com [40.107.14.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93A319B;
        Wed,  5 Jul 2023 01:42:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZVUufogVVdQsJ/UzYEDlSwjv+SNDZXf2Uj9XPo/1EBgwhnqv0w1WEonf+KFJLM7KrvKLDk5cGWHSBN6CqS6tgaUia9PpIMIAkS4zO7KWlvHv5qVJNfbvxmeD87Up3cFxJgPmMicvbJEG1qIKBlDqxTYSvwLDxbW5swr59zW9D4qUANJDSLlUGZvuWhEq4C0/wx+/rXi6vltdUziYvq1Mz6r8XSVozWWg77cm+houd7Xs2qprjDYHspyCYo03qNwNpsBITnoLXVX7KHbWr36VF/LeJuRP5IlgSU/zol9tVgw55aEik2hP7sLHpFPx/1dcSkHYJSKXF+I7ipHkRiX/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3G0oGEWP5xBzGK1sLBABci+hI4I5xaMrjdu16ttbS2k=;
 b=LdEWwwahp3My3tZZVKAc67wYgmqdNapPc2lMBSBAcOc95zZtL7kGAtygg5AtpRniYhkUk48UTvzqfAyHAS45M2zthtqKR71Z+jC1cyWBQZNmm7JcPvQUVF07Q30idnbOyGC9C2AEJzYO5VMvrzdQIOR5VoN0t6Drk3+cSQBfysAT4F9d1vCaFx30kDqZh1IM4FWQnu/66G/lXxIKOgQQ31DWu6GXZnsIhNlDpoWLSTBNGcyirUL+Oi6I1cHVi2aYt9TraAj4wZ077QZBdmFEmQ3hizLGDuA4dwjREgdVtUHn5Qh5EjN21rsHQ4FzR6jJAS/yIX5Yt2nxj+1wx8H/Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3G0oGEWP5xBzGK1sLBABci+hI4I5xaMrjdu16ttbS2k=;
 b=iXsxauAzdsThEuxCMfNRX+TGXuu1aQJQGpgh6cwoHSS7t+AppqawtGJ6O+2d0/O9SLfS4gk5mQ/LfLM4NHbA8t+6dTrS1/s8myLffgd75A9N6Hh4ucQPUUWxJHGTQ8arAe7AEsHMHYrQnu1Z0zNssC9lr57N+7TMFCdIiHu6Oc+g/hKoC+b+MkWQuU8KBEqlLezc0/GtmpYop8Q+qQTDuBg/f//+bZIhXHbcd8nq+tFnXmQuIJjD59pIQQ9P70vAXk5Z24UCFIpX6XiGJQhrqCZ1aPHR159af3Krq5aDcdbiR4HgOsVYjztfEN7UA+/HlSMmjV25LF2LM0De3PQiZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
 by PAXPR04MB9188.eurprd04.prod.outlook.com (2603:10a6:102:222::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 08:42:04 +0000
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::637f:a940:d807:34c2]) by DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::637f:a940:d807:34c2%2]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 08:42:04 +0000
Date:   Wed, 5 Jul 2023 16:41:48 +0800
From:   joeyli <jlee@suse.com>
To:     Weiteng Chen <wchen130@ucr.edu>, Yu Hao <yhao016@ucr.edu>
Cc:     Yu Hao <yhao016@ucr.edu>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: How to reproduce the BUG general protection fault in
 hci_uart_tty_ioctl?
Message-ID: <20230705084148.GK5866@linux-l9pv.suse>
References: <20230628150140.GU21539@linux-l9pv.suse>
 <CA+UBctDPEvHdkHMwD340=n02rh+jNRJNNQ5LBZNA+Wm4Keh2ow@mail.gmail.com>
 <20230704030131.GY5866@linux-l9pv.suse>
 <191B9131-6E47-49B6-8089-108E2B12B9DC@ucr.edu>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <191B9131-6E47-49B6-8089-108E2B12B9DC@ucr.edu>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: TY2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:404:42::13) To DB8PR04MB7164.eurprd04.prod.outlook.com
 (2603:10a6:10:129::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7164:EE_|PAXPR04MB9188:EE_
X-MS-Office365-Filtering-Correlation-Id: a9b49d27-1684-4610-808b-08db7d33b551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XeI+j3Swz9KPbLu+JAj3zVsh0JDxDbyxtshf7chl+Vn3L5R0Gjko9OvR9LepvmfLHmab6Q6B2gJIo3r+JEHj+DbYjvyv0gP71HaDW3p8v+9tnYTbf44TrB+LNYyJUC/22D0cQdbqYP8tOgZiICnPpDandS3imw99fljA/Axc3MklrD86fxt7dr2Xtea+xJ50zmi0XF5t8oS9u18xEwPulbpWUGHQUqINhs/vBZ+0cOTMAJ0C7tqnk4FFGqcR6MhSuPTUwAA1Wbz0kHK1UxuAfvCYkx/jP4MRfQcF3Qr75kDvFBMnSui0SxSlHRpxgHwnwo9g1AZAIPZv0cZeXEazuNOPllW/cTfel/cGF3IKGfrXSR7k6se1PTva14To7cg3g/qYVoq29wGN44qkjiWI4Bc+dgfBS1QJ743Eu957rbVBiQr4GHxl3Gc5sFaBMn++V1ShgIvyzVbtMUOR1/Y2Luqwsk0M2QqmV8rZTM9psU4R9clweOid2ObfN9xZaCY7JHmfNOO23J90TwWpzFTmip4L8RB/fa9xhTNStU08mzg945thToIVOIZWf9uCPwLB8APRYRiiq8VLbHLISjdJswBR0FLlrjJVeTxVrvwHH9fBUH5XhXFONc7ciVv4dOy0oknYzjTJXBVqqtC0ED557w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7164.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199021)(36756003)(110136005)(2906002)(478600001)(26005)(9686003)(41300700001)(33656002)(6666004)(6486002)(86362001)(966005)(8676002)(8936002)(5660300002)(316002)(6512007)(66946007)(66476007)(66556008)(38100700002)(4326008)(53546011)(1076003)(6506007)(186003)(83380400001)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXY2OWJicWNzN3RYMjR0cUt6cy9lTzljRmZKdERqTnRKUWRjUmVMN0dmZGMy?=
 =?utf-8?B?b01JKzBrTXZsRXRyaldJZytva1JGT2lBN2M5QXJDL3ArS3hITHJZT010enVs?=
 =?utf-8?B?eHRYck9kQnd5QncxTU54dWIrUjVvUUppMjF6N3locnhCZ2Q0bTU3ZkV6QlRJ?=
 =?utf-8?B?aWxHVWk5R3oyLzZtUG0vU1g2MWs0VUJiVktyRzdYemFhUXhZOVdmNGIzNFk1?=
 =?utf-8?B?bC9EbFdXNk9sZnhFLzBnbWVLaHZMbmx1L2ljR1lobGFmV2dLcWc3OTYvNm9B?=
 =?utf-8?B?UDI4c25lRE5XSUduMjFTd0p5ZnVKc1V2S0lDUlV5bEczM1UxbTFOMlh0SFFZ?=
 =?utf-8?B?L0hyR0pudVNORDU5RzZBSmZnd1pxVDEyNkpNMmhzb1VxQlcxaU1IQ3Zucy9G?=
 =?utf-8?B?Z3FnNkgybG1SQ3hkUlM2TXNSTnZwUGZmaUordzBaQmVmQTZIMGRoMjUrTXZT?=
 =?utf-8?B?b2F6dFNwWjk1dFlPakZqaDc1OHVRTnc0aGVxdnlQV3lVTDRCSHM2ZnJtZStF?=
 =?utf-8?B?ME01ZjR4dWpLVXBDaVd4Z3VJK2FIRmZHTW4xUVpaVVJwVlpHY2ZKL21SUHlE?=
 =?utf-8?B?akJ0VTkrbCtRSEZRYjB6c3dmekNOc3IyZWM4YWlGOFVSUkdGRE9NR3NIYVpS?=
 =?utf-8?B?OHZDRXZYb08vVi9XQWl0L3JjL3RCOGFtNUxBdEEzTVVlcVJjQVRqWGtFd2U2?=
 =?utf-8?B?ckprbEtNbHAwTmhDZ2JoVWREZXl4cUR4RkZJV240VGtxanNpNGlOZ0dSZ0VD?=
 =?utf-8?B?UkxxWjRwQWJPK3dKRjVrNlUvY2hyQkxERFJ3WFdxUENvQjh5MFMwREZrQlZh?=
 =?utf-8?B?VzdVV3lUbHkyVG0xbk5yRllVckgyL1llM0JrODkveTVDbDFXS291R3U2ZXE0?=
 =?utf-8?B?ck1lWUY2Y1JPRmJxY3BuZzRSaEF3cXJpZ3RUcVFRM2E0TG1iTEZLL3JucW1M?=
 =?utf-8?B?TWdNMG9heHlUbzh4OFFSSDUrbmVQRTVhZTY2VEVBdHB0YU90QlRvb1REdXMx?=
 =?utf-8?B?WVg1OWxzSExQTUZGa0RYR3NIUEFuU1ZBYkJIdnE0NndXQjZqc0NmQVJtUFlW?=
 =?utf-8?B?bzdqOWdyZU15WXRzbUgzOUpCTnZNVGJWbVNOQ09jcEt5NmhkajhhUU44WSth?=
 =?utf-8?B?aFp1Y0UvTjIzamNqaitJdU4yNE9VN1NvaW1KMHlLaGRzdzA2Mm15dytNZGRh?=
 =?utf-8?B?bCtiTDlkb2xXVGdLZ2lnUWdjakdWbFZ3UWhSanJ5aWJ5MHJzU3NGVnVLQmwr?=
 =?utf-8?B?OEdnanJ4Y2pIOTRPdEJhKzZ0Z1l4WGIvTlBJZzRtcDh1UXcxK1V2ZmxaeWts?=
 =?utf-8?B?b0lJWllDbWJSN0NTSDk1NURzVjVRTEFCbk9pSkhsNmE4Zllob2lna1Z0TVBl?=
 =?utf-8?B?Z2UxMDlkN1JtNWpQNzc3WHZWSnM1VzdMRE9kOWVYbXNWb1pwZXJPTFBWenJI?=
 =?utf-8?B?YWVJY2pBTGQ4Y1JNWW9ha3VsbDlSSW9kTW5DR3JxOWI3WUZ2WkxjcmxEQkR5?=
 =?utf-8?B?TVMwNmFIQzhTZW5TemtFUHN3NXZidWpYTlRaQk1FZ3lwMktsdHlVYUFxaEQy?=
 =?utf-8?B?OTZBRlh5MWhZakpGQ09YNlpQMWlPTUY3Tk9rUEtWeGhQcmJZV1oyb3hIMmVN?=
 =?utf-8?B?VXJUV255c1lBekVtYnlYTW10eXZLVWc2U2JYL3ZiQmtDVCtsUEs1enJSUU1s?=
 =?utf-8?B?dGk2LzhjNC83SnRnaUNTdXRSTmUzdFlOcGxxOE51eWRSb2dnYkwwUHhzejVC?=
 =?utf-8?B?NUQ0T21lM1lkT3NGZ2JvdURSV2NBbjdqUU1aYmF2N1lNM0taQ0dTZlBNRlo2?=
 =?utf-8?B?cTM5WHlqNEFGZjY2c1loWVArSitWejVkbnpScnF3Zmo0anVRaHVBdCt2UHpo?=
 =?utf-8?B?TVBNaHdyTmhNemdLcEk5YnNpZnR1QXIvWVdtUkcydlRHT3NQMVJBZUdPTXll?=
 =?utf-8?B?aStRdFcwanRBR0tMWlIxTFpWQzFTRWRoOG85cU5uNnJoUVc5WHF1YXV2VHhM?=
 =?utf-8?B?Qit5VHJCRy9Tam9TREhYMW5sd3pXZjJGTUg4SnFDNTlhWGp2N0JQc0x2V2Vi?=
 =?utf-8?B?SWpDMFN5VUJpUU9vaEVtc05FSEMxOXRUWVl3VXlWQzNCdVZxMzhZUXJNNzRM?=
 =?utf-8?Q?fC3w=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b49d27-1684-4610-808b-08db7d33b551
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7164.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 08:42:04.3785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJ3038qA9op3oUUWNjQmx1g5nek9nI+QjLnhkRqDIyzBWJ+tvQC3BfU3/Y0r6ggA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9188
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Weiteng Chen, Yu Hao, 

On Mon, Jul 03, 2023 at 09:07:38PM -0700, Weiteng Chen wrote:
> Hi Joey,
> 
> Sorry for my late response.
> 
> https://elixir.bootlin.com/linux/v6.3-rc7/source/drivers/bluetooth/hci_ldisc.c#L764
> 
> switch (cmd) {
>         case HCIUARTSETPROTO:
>                 if (!test_and_set_bit(HCI_UART_PROTO_SET, &hu->flags)) {
>                         printk(“test_and_set_bit…”) // insert a prink to make the race easy to trigger
>                         err = hci_uart_set_proto(hu, arg);
>                         if (err)
>                                 clear_bit(HCI_UART_PROTO_SET, &hu->flags);
>                 } else
>                         err = -EBUSY;
>                 break;
> 
>         case HCIUARTGETPROTO:
>                 if (test_bit(HCI_UART_PROTO_SET, &hu->flags))
>                         err = hu->proto->id;  ←- null pointer deference
>                 else
>                         err = -EUNATCH;
>                 break;
> 
> This is a race condition between HCIUARTSETPROTO and HCIUARTGETPROTO. HCI_UART_PROTO_SET is set before hu->proto is set and thus it may dereference a null pointer.
> 
> To easily trigger this bug, I inserted a prink in the source code so that the C producer can easily trigger the bug. Please let me know if you have any questions.
> 

Thanks! I can reproduce the issue now. 

Weiteng, Yu Hao, do you have plan for sending patch to fix this problem?

Joey Lee


> Best,
> Weiteng Chen
> 
> > On Jul 3, 2023, at 8:01 PM, joeyli <jlee@suse.com> wrote:
> > 
> > Hi,
> > 
> > On Wed, Jun 28, 2023 at 06:57:47PM -0700, Yu Hao wrote:
> >> Hi Weiteng,
> >> 
> >> Could you give more info about the bug, e.g., kernel configuration,
> >> qemu arguments.
> >> 
> > 
> > Base on kernel code, looks that the HCIUARTSETPROTO and HCIUARTGETPROTO
> > blocks in hci_uart_tty_ioctl() should use hci_uart->proto_lock. 
> > 
> > I have run the C reproducer a couple of days in qemu, but it did not
> > reproduce issue until now.
> > 
> > Does anyone know how to reproduce this issue easily?
> > 
> > Thanks
> > Joey Lee
> >> 
> >> On Wed, Jun 28, 2023 at 8:02 AM joeyli <jlee@suse.com> wrote:
> >>> 
> >>> Hi Yu Hao,
> >>> 
> >>> I am looking at your "BUG: general protection fault in hci_uart_tty_ioctl":
> >>> 
> >>> https://lore.kernel.org/all/CA+UBctC3p49aTgzbVgkSZ2+TQcqq4fPDO7yZitFT5uBPDeCO2g@mail.gmail.com/
> >>> 
> >>> I am trying the C reproducer in your URL, but it is not success yet:
> >>> https://gist.github.com/ZHYfeng/a3e3ff2bdfea5ed5de5475f0b54d55cb
> >>> 
> >>> I am using v6.2 mainline kernel to run the C reproducer.
> >>> 
> >>> Could you please provide suggestions for how to reproduce this issue?
> >>> And what is your qemu environment for reproducing issue?
> >>> 
> >>> Thanks a lot!
> >>> Joey Lee
