Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76125FB261
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 14:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJKM0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 08:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiJKMZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 08:25:58 -0400
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C5A543CB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 05:25:54 -0700 (PDT)
Received: from 104.47.13.58_.trendmicro.com (unknown [172.21.19.113])
        by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 038D810055815
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:18:25 +0000 (UTC)
Received: from 104.47.13.58_.trendmicro.com (unknown [172.21.173.179])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 19B2A100017B5;
        Tue, 11 Oct 2022 12:18:23 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1665490700.936000
X-TM-MAIL-UUID: b8a60d4b-62c5-42e4-90bc-d6032e9fd798
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (unknown [104.47.13.58])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id E4A2D1000389C;
        Tue, 11 Oct 2022 12:18:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULqd6N3u/VXfMNfFB87X/bpXV+zwrySYtX7X2D4VdCtU1h1kr6Ki7WjT26nJcycekQKv+uWwor5bFGp4Kqn8shBuf06LY0D+yhxZaoE9/GTchDUWHFIhuNiHji+GvVdMI9sb5h/ldYPR+hizpIdWCiwD5qZs+2+oc8DoYJ62EyNibXYDaygc9VI1KIcMkGD2HWOuDzGpVOXwMWwtU7rvgZF9PVWTYqv+dwGwqgNNXLb2MUQcRzrbaLChyCfm6Z04X/xiKxdWNTBli4PoZ4qTdtpuEKZNRJVwKM6K17aiTaobSA0XnJ9mq/68+dVoyb6UG2tgN36r81RNRO/5cvL5fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4QFbV37INRAPIEeJzM1VBjVSVvmZRiHi+tdxXdX5gg=;
 b=iAPdre0DaFGwNNKM2EupPBkXtQmYSbAGEVs3iDlCC0kfGDfZ24qrobd07xiuzw0bxBjh6zm7bAEobbYk6NqKwZpDAJPIbDkw26LyhmjW4rBkYAT61JealoxspLW/+u9iWnviFkb7WoucEKfAlajMhDaM0w3i+oKT6x6LAWthCGpVJHrGS7TAVWQRyh1PtO2VsY+ogXY3xMxh+yyoJ172JrpECwGFwXeyMS4uoy1b66HCs2E4eY+ZRxeq1TKWBZ/RvVSfKn+FtMjQ5SokiGQ/TTCDr9P44ZC+zQE/ivPVsZRaQC4VnUnUwfr3d1guCZLSBbZGlrWSbqgbFyEhfx1KgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <794b9160-9647-7157-c84f-e278a375716e@opensynergy.com>
Date:   Tue, 11 Oct 2022 14:18:17 +0200
Subject: Re: [PATCH v3 resend] Bluetooth: virtio_bt: fix device removal
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Hulk Robot <hulkci@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <20220811094542.268519-1-mst@redhat.com>
From:   Igor Skalkin <igor.skalkin@opensynergy.com>
In-Reply-To: <20220811094542.268519-1-mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR02CA0118.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::15) To AM0PR04MB6641.eurprd04.prod.outlook.com
 (2603:10a6:208:177::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6641:EE_|PAXPR04MB9423:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f7c9b77-33fe-4e05-3f4a-08daab82ae83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZsmvd3ddGFhdypKDjS2049I6numml2AtFD7YQ69qkcC1gZ2nF7N4Htkxw/22HiX1CPNakF5rKhS65s2wjOm3ttiAKEwiUyvu0ic9zF1fo72q3wNGGqXhL5ApqeoYM1mEFBEu9krnBkXHEWjUy+YsovyawpaRoZ9U1pqdUSdFih+R4dM8/FuC6bMbtgzWTs1vOlTdl54q+g5q2269z3kFmq8TEMKKSIgPFFwC9gvRTM2s+vSSsmnN4nQXvZ0zzp9X7QwaLyTcQyLqjVVks5Ta3xA+Vk3YZhOeuZUykK6SpeHZapGSU0cyTb6M4JTC9ifJ6mr+0zYxv2ZFmxya2fBDPtXygjUKtBmpahR7R2OeCmB2hKWr3yBATU5M+hO8lKQfT6Z3DpSDEvTRY2P5Zrz5GkqOUsdfBOdCWl/qHGrPAIsgbsgg+hSL244nhv8q/hGNXG1UNXkjA4XH3/QEdC7Npu2Mcr2abxt1mwK/EXYqdN6EsCUEtsZ51SC5KJyW4dzAYhbITZRzw2TYBPimgm+/+hMVe3T8sljqEPxJrjb+9+J+fhuw/aEMoa3LmqyUsX7qBKIHiaV3x3I1D31PAdQISFiRhx1MRty6I4GNnknOQnzSRpVZf42BFgdaKDKBT7novqCWxXyvjFddffyxHoMgj1f8avn2bYn3ejHI+nryQ2wIpwVEqfMb8j8Sk6nwwyhtEZMYcGyUNIXV29UK1q42g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6641.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39840400004)(396003)(136003)(366004)(451199015)(36756003)(86362001)(31696002)(38100700002)(316002)(42186006)(54906003)(8676002)(8936002)(2906002)(5660300002)(44832011)(66556008)(66476007)(4326008)(66946007)(41300700001)(83380400001)(478600001)(2616005)(53546011)(186003)(26005)(66899015)(31686004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REJDSUsvb2ViQWNhdHJuNXVBbkZ4bEttL1gzejA0dzdoU2lZUEFOblVwRWR1?=
 =?utf-8?B?VnZ3ZGo3VVBHRG5JZWlVTUk3d0E1NU85a01uUjlYYXFKTXBWT0xxSmxac0NJ?=
 =?utf-8?B?dlI4QnIxUEVlcEwzdlp5b3B3bWs2KzFjSHdmOUJ4akpwOEx3WmRPUThJdXBs?=
 =?utf-8?B?bnNvTExZeUFLNGdNOXBLbVBBWXRBcjNKcVVxSytQSzVDdDl3RmlxbjBkWEJF?=
 =?utf-8?B?NURjejF4by80YThvT1EvRytlbG9MOVUyTjJXUGtjbnJnVm9jNzNKWDF2akFj?=
 =?utf-8?B?elNrSm96NEswU21STjVJdDZJUlMxS3dBakNVUFEyNkd6WUo1N0hyczBaK01N?=
 =?utf-8?B?ejdNak9aNVBlTk1NNE1LcFF3WVJ1dnNVQTY5djRQaEU1cFBhZmN3Y2lwa1dM?=
 =?utf-8?B?T3R5aktlQW5mWmtuUFlBTTl4SXlQU1lFUGw2R1R6bllOT3RpaU1Wd2hGVlF6?=
 =?utf-8?B?L2NZN1V2amhzUVJsKzlYMzlLcUR3OHdUSkYxQWJyWHlnQ3pjeThYVmdoZU5Y?=
 =?utf-8?B?NXFJMTNQY2hjZHgzQ292biszVEEwTUlBTC9FRlQvS2FJalhJc2IvSlF3MEtv?=
 =?utf-8?B?UTcvN1pORkNyMUpMUDZaN05DckJVNVh0eUdTMnBFaUpXNDlXWTdybTVkNlhi?=
 =?utf-8?B?VFhaZmVYMUhNeUNtUklPWldneUtuN3pzUUtyUVFWbFBZdFEvb2VyNUlpTTUv?=
 =?utf-8?B?Z0Q3S2krMHcyRlRvMklKaDc3NFpSb2hhcUdPMHdYRXBlS0p3bEFMT0xJeWR6?=
 =?utf-8?B?dnAxVHI2SjJZdDVyUlZpOWtHWlM2MUR0Y3hSRGIydE9DSURra3Nuc3pnck9t?=
 =?utf-8?B?enRlZ0ZyL1RVekE3WjVtemcyZ0h5aHhyeVdETHFUS21DR20zUVZXVEFJbzQw?=
 =?utf-8?B?V21lUzgvTDUzWmRhR2N0UnZXYUFXaGpPSVVOU0ZBaHFwR1ZDbXZOTldqNWln?=
 =?utf-8?B?UUpBdEZKMXQrQzZOemVEazY2REVSOVNjTjVDdWIzeDdHcnk4U1QxVjVJTkph?=
 =?utf-8?B?aFVrQUZtbWhLQTVXRlhxVUlaRFlJa3FUVUpOS1hvZHlhdm5ZRG1XL2V2d3hl?=
 =?utf-8?B?MGJYWGJ5K1dVUTlVdDdPcUNTcCtRdlppRGRpSXkvSTA4cy9nSExVbUlwWElL?=
 =?utf-8?B?Y29pL1Yvb1ZobW4wc2hSTkQzM1gycm5ndjh5SVlCTytSWXZRQUMvd21zam1J?=
 =?utf-8?B?M1B1cTRSZmRuWnI1NExMWU5maVhmQTBMWHNQNW54OW5GSkt3Z2hmc2dOZ1pY?=
 =?utf-8?B?U1hKV2Z0UnhvU1ByQVNSOGlkTXpHazhOYWhIVEV4N0IxQmoyNGE0V21oZ0VW?=
 =?utf-8?B?ZEpXdllHTFBXSmNsMmdXSWVUTmZQS0hQMmhGRGFKYmxvQnF2UGVVR2ZLRDRa?=
 =?utf-8?B?MS9oajlTd2VySUVmRUl2dVdtMlR2YUpYazYzd1R3dWNQU0dCOTRRY2U2cUtF?=
 =?utf-8?B?RUFsYU9iWUt2OE5BMTJBYU80bHlYY3Z4dUVCeHp1ZzBIT1Z1QjIvOHVSQU5u?=
 =?utf-8?B?bElwLzVRQUYyWEZqemhBUkVuZnZQODRBWE1rSzREOFRZQjRtVUxQWG9jR2Er?=
 =?utf-8?B?b2tsTk5KM0dNOHB5SXlEc1kyMUVmS21lNmV1SU9zbU9NY2tmM2Vjd09Bd3ky?=
 =?utf-8?B?aXptekNRbnBUQ3ZrNEQ4RVlyRE5kNzVaUlNJWE9YS09OTGxUMm4zOGtOZVZu?=
 =?utf-8?B?c1FiQlpkNHBWaXg4cjRNbE1EYlJ2V3hYWGZYVGRZS0pNRlI0WUtuZTF0YUVj?=
 =?utf-8?B?cnE3SFNsUXlHQmIxWnplMVRoMzNKa0JPdC9MSEw3M0hOQk1sc0t6NDZJRFdF?=
 =?utf-8?B?NVYzb2VSckFEanA4Z1NoM1NmWHNlaEJyVmpSZzhKWkxSRS9DYkVvUnhSMWg0?=
 =?utf-8?B?UnpLTGR3S0NRVUZ4SFpDWW4xSExHZVRIeXFJaThhTjB6TmlmZlJVZ2tPNWdX?=
 =?utf-8?B?TjV3VFc3YktXK0pEa0lLYXltdFNwTDN2aHJSQXplUzVzZlJlcWdxRXgxc0hy?=
 =?utf-8?B?MFA0K0ttdEt5MHE3WndxbDl3YjhaTUxoOFFMdHlxK29FS1lSSGora2kwLzQx?=
 =?utf-8?B?TmpLVVR3QkdsTWg2d05ERkx3ZkxLRzVTZEl3K0Ryb2lMSXlLNitkcmlZVy9t?=
 =?utf-8?Q?EJ8bFV9K0LzZe330oRJcAmK4p?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7c9b77-33fe-4e05-3f4a-08daab82ae83
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6641.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 12:18:19.0000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+c1WJqIOt4gVpaGgq5hg+csLe1+//DTpdhyzCpCjMxqrxlDoeFfdpAjlblAssSYBAsVqNRlpktAjvgluuxX5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9423
X-TM-AS-ERS: 104.47.13.58-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.0.1006-27194.007
X-TMASE-Result: 10--15.667900-4.000000
X-TMASE-MatchedRID: gzVbiXtWD9uMp9w0tjqOxRHJWwDGGGOs9mojSc/N3QdlEv6AItKWF74E
        LhML5UNkujFpPbv2ZS1TbKunqk1vfY8ZguM4px/K2ymWcHNzzEylY4F8r0vXP/frxqj+aaaTUHm
        yON8GoiDBV4b4vif9P2LHY2Sa26jFq6H6eyKIRsP4Zi3x/9WFO9Iv4RV84lHTycRAPeSZ1h5JLH
        juVNXQlGawocwifVZsQD8RTZIrvMD11/qiZ3ytjxlxrtI3TxRklDt5PQMgj03mWHHSYEnI8ZClV
        uR6WzhZIvrftAIhWmLy9zcRSkKatdFMBnmJRh/JGYJhRh6sseuOhEhoAl74KAMDMjg5/XA5WDtw
        fhI6Q6nYFONbuv9GP04dePz5C65OpeAIK6XfhPpmD6WMQxhqLv4ydOVsf93F4Ju5UjuFVstv2Zi
        uCbVzY4lOTESqnG+h6xunr4cOZYWO5neSQZsYSZBJBiU7RK2s/uMkyuMzAoPPM5ZdaYK1wNG3lM
        tRFHHJ585VzGMOFzABi3kqJOK62QtuKBGekqUpI/NGWt0UYPDYCA6ryEhF+fpqBK3mDZW1OPrvc
        T+FZLEJP2A59s+E+5BE63rlODpp
X-TMASE-XGENCLOUD: 0ea26205-7c7f-4daa-b30e-012592bdc2f7-0-0-200-0
X-TM-Deliver-Signature: E0BAA5B1B5D1FBC4B07A5B47E00D9763
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1665490702;
        bh=pFu/eaTjtuhOJFmAwfFS4q6yDrEK1l/+TyuWpV3AybY=; l=3988;
        h=Date:To:From;
        b=ItdzdRpMwcDpB4ojvLkdq6NEu2tCsvaHjsvSZG7mdRAHGSudpW75F57zdUtWAMrgx
         xlM3b52hP60C24SAAGw0P2iHTbnhQAITE5TFtrY0D8y71AGM8Mr+Ma/ENJkdA9bHrL
         rv0eeYYeDIznq4jveAKg3WrmUutwdmIDSOhq2bhv8GP5LIBDHtG8MPUiMwYjP2iVt0
         j6/+rUJydTvPnRNSt01SOrdGtvvLDIsQksw9if6MtVqfsDMqqOns1niKaCbwU05mDP
         rXrik9iBSmKLAdTNikQmk/BgXIEkol6Dv7W02ZQlApqD8heQ9Q1t1VuA43EMGhZA71
         GBas+bGef+RXA==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested, works fine in our projects.

Tested-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>

On 10/10/22 19:14, Michael S. Tsirkin wrote:
> Device removal is clearly out of virtio spec: it attempts to remove
> unused buffers from a VQ before invoking device reset. To fix, make
> open/close NOPs and do all cleanup/setup in probe/remove.
>
> NB: This is a hacky way to handle this - virtbt_{open,close} as NOP is
> not really what a driver is supposed to be doing. These are transport
> enable/disable callbacks from the BT core towards the driver. It maps to
> a device being enabled/disabled by something like bluetoothd for
> example. So if disabled, users expect that no resources/queues are in
> use.  It does work with all other transports like USB, SDIO, UART etc.
> There should be no buffer used if the device is powered off. We also
> don=E2=80=99t have any USB URBs in-flight if the transport is not active.
>
> The way to implement a proper fix would be using vq reset if supported,
> or even using a full device reset.
>
> The cost of the hack is a single skb wasted on an unused bt device.
>
> NB2: with this fix in place driver still suffers from a race condition
> if an interrupt triggers while device is being reset.  To fix, in the
> virtbt_close() callback we should deactivate all interrupts.  To be
> fixed.
>
> squashed fixup: bluetooth: virtio_bt: fix an error code in probe()
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Message-Id: <20220811080943.198245-1-mst@redhat.com>
> ---
>
> resending due to v3 having been dropped
> changes from v2:
>       tkeaked commit log to make lines shorter
> changes from v1:
>       fixed error handling
>
>   drivers/bluetooth/virtio_bt.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.=
c
> index 67c21263f9e0..f6d699fed139 100644
> --- a/drivers/bluetooth/virtio_bt.c
> +++ b/drivers/bluetooth/virtio_bt.c
> @@ -50,8 +50,11 @@ static int virtbt_add_inbuf(struct virtio_bluetooth *v=
bt)
>
>   static int virtbt_open(struct hci_dev *hdev)
>   {
> -     struct virtio_bluetooth *vbt =3D hci_get_drvdata(hdev);
> +     return 0;
> +}
>
> +static int virtbt_open_vdev(struct virtio_bluetooth *vbt)
> +{
>       if (virtbt_add_inbuf(vbt) < 0)
>               return -EIO;
>
> @@ -61,7 +64,11 @@ static int virtbt_open(struct hci_dev *hdev)
>
>   static int virtbt_close(struct hci_dev *hdev)
>   {
> -     struct virtio_bluetooth *vbt =3D hci_get_drvdata(hdev);
> +     return 0;
> +}
> +
> +static int virtbt_close_vdev(struct virtio_bluetooth *vbt)
> +{
>       int i;
>
>       cancel_work_sync(&vbt->rx);
> @@ -354,8 +361,15 @@ static int virtbt_probe(struct virtio_device *vdev)
>               goto failed;
>       }
>
> +     virtio_device_ready(vdev);
> +     err =3D virtbt_open_vdev(vbt);
> +     if (err)
> +             goto open_failed;
> +
>       return 0;
>
> +open_failed:
> +     hci_free_dev(hdev);
>   failed:
>       vdev->config->del_vqs(vdev);
>       return err;
> @@ -368,6 +382,7 @@ static void virtbt_remove(struct virtio_device *vdev)
>
>       hci_unregister_dev(hdev);
>       virtio_reset_device(vdev);
> +     virtbt_close_vdev(vbt);
>
>       hci_free_dev(hdev);
>       vbt->hdev =3D NULL;

Please mind our privacy notice<https://www.opensynergy.com/datenschutzerkla=
erung/privacy-notice-for-business-partners-pursuant-to-article-13-of-the-ge=
neral-data-protection-regulation-gdpr/> pursuant to Art. 13 GDPR. // Unsere=
 Hinweise zum Datenschutz gem. Art. 13 DSGVO finden Sie hier.<https://www.o=
pensynergy.com/de/datenschutzerklaerung/datenschutzhinweise-fuer-geschaefts=
partner-gem-art-13-dsgvo/>
