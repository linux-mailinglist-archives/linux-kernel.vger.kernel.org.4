Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8609B6B881C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 03:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjCNCLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 22:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCNCLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 22:11:00 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91663848E6;
        Mon, 13 Mar 2023 19:10:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k59+v/+bNMmmG3bwvSM9TmfcHu4jniDKxfud1cfPlKXRQqdJTIKNFRPb2c2Q8KT3NPYnYfzKnzr7Ak35rYIRDKlxQWdT8xe833uzN93CE5X3N4j6AQCDf8SJCeUwbWNErPXK9MiZq92CnIqqSJKf3rIyJlqKv2L4K3YjisZTB6mRsa7tC2d3pzxjaGNhgtoQnt6JsViQvkxttZ/tHLtqZRS7/gl6R/R4+rJ1qhfgarqBKqVrDf++v/cYSgpo47pzZwb7Uo0WwCNpD2S5N7E8sMbIjvXsw5ExmUQbwlROI221dTAp203CeSeI+8m9UTaK+xb3PmGSpnif2/o9ArX+pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hAz4q2J/zFffXDzeroPDlvlgW4EU3rmnxWrVYXWYvU=;
 b=iYC7MjflOz3d5+R52Yxb09Mn38f09hYx0KKkMbkkQSjLePvdh7RBeJgA97wxqyoUpndNiLBaVhqwTSMAigl9b7377v2JyGE5Xo2X0AMxVfTrK2qZQZ7dVOGoG74/KwTxYUZV7qEOpSxP3egT+BbHeGzgm+VMVGw5xgasdQisTy8eq6+uAMH+ORLwFBrPig0ByhnLq96rz5xD/Wms9OhqTMXh/aReZT6RC6Qga8EbRE/zvIz1ZsDL4O9bw7v0Rqu25vsylj6BtKMW9AwG6EGCYSyXyODoZXw7dGvyzvTJvHDvhbnDJLXPO+cH7kTtUK5o3dxIgwu4axvyHwpvje0HkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hAz4q2J/zFffXDzeroPDlvlgW4EU3rmnxWrVYXWYvU=;
 b=rhwp4qMU3kJ6ctG9hgS6/pH6pSjVQkzxB0UG1oMqAhVBgEXzsgQipmr2GXc0GZiXap8wxwsuCB9vzEA+MptiMgAtHU2WmzhNEEvcgblY0Bvkt3pVgJfq1Yago+cWsFCCN32mVX0Gx7VwXN/a8OwzRN/zBQNUpPquTOaE2IjKPCw=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DU0PR04MB9561.eurprd04.prod.outlook.com (2603:10a6:10:312::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Tue, 14 Mar
 2023 02:10:55 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b%5]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 02:10:55 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        "tfiga@chromium.org" <tfiga@chromium.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "shijie.qin@nxp.com" <shijie.qin@nxp.com>,
        Eagle Zhou <eagle.zhou@nxp.com>,
        "bin.liu@mediatek.com" <bin.liu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "tiffany.lin@mediatek.com" <tiffany.lin@mediatek.com>,
        "andrew-ct.chen@mediatek.com" <andrew-ct.chen@mediatek.com>,
        "yunfei.dong@mediatek.com" <yunfei.dong@mediatek.com>,
        "stanimir.k.varbanov@gmail.com" <stanimir.k.varbanov@gmail.com>,
        "quic_vgarodia@quicinc.com" <quic_vgarodia@quicinc.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>,
        "ezequiel@vanguardiasur.com.ar" <ezequiel@vanguardiasur.com.ar>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "daniel.almeida@collabora.com" <daniel.almeida@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "jerbel@kernel.org" <jerbel@kernel.org>
CC:     "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: RE: [EXT] [RFC 3/4] media: videobuf2: Use bitmap to manage vb2 index
Thread-Topic: [EXT] [RFC 3/4] media: videobuf2: Use bitmap to manage vb2 index
Thread-Index: AQHZVbQHYvopPzbkcUeiL1IQ3S1A1q75h32Q
Date:   Tue, 14 Mar 2023 02:10:55 +0000
Message-ID: <AM6PR04MB634195FDE919FA9462187045E7BE9@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20230313135916.862852-1-benjamin.gaignard@collabora.com>
 <20230313135916.862852-4-benjamin.gaignard@collabora.com>
In-Reply-To: <20230313135916.862852-4-benjamin.gaignard@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6341:EE_|DU0PR04MB9561:EE_
x-ms-office365-filtering-correlation-id: 3b135925-5dce-4ff5-f866-08db24315820
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OSZOyXMkSSxqHMEdVE1fvHKjw0OhqQKeu54/OnK311ogLBnISNTJRTlmvxTOPDx+7/9gZaI5+rjjN558c6FqkjWYXh4vea3TYLMlezgxM5L6Emficyn5rXQZq1KVC6TB2BEOY5kGOg4cDIVzZMd6hz8mSLHei/H73FRIfYgdQvTEE3ayaze7n9VI6CwLBh2Bop/OeWp2cmGin9p2+V4BGQn8JULmpCITMbVT42XUkCbsCEkQgnQNhP9TnGcDpDA9fsj6uWiQagWXv94+Hng7EaQbqPloHqDkXtehy4QvEKIz8/UbN4GFBEbp47r004s72/VTrZlfnOf2jdNM253S65tyDWb4BXTSHZkrFg1vqKSIviJO19y5JfLc1dlfbHL1YBn0h2/oGHaB/dHMe+xa4ZVDfidsJmzcSdrPluICLFn2yetlKe21N6KhLj1PBXxRR/65WwW19N0rPTYLe6doq/9qinRMID9NO67kT2EpamN5cxmpzz7F7GwxDDl5UXcaCC61doJ163w0FSkr0ubkmlIAtUkr9VAmIsYzr3Vd6sqHdT10ud93G5Q9xvt1L7JnuGNLoDIYZXKHDE/Fy/rRQaBZUyxWaea0ONExEpEqfzfuX1QTPbegAeplN2yhWg77NmZo6Ik6APg1LHrqlHY9IxMruKo8CoWB/7Xu+Pc3XzQds8IY+0B/TeJ+7dy4v1hP4nmmFR7GBv31Jx5ojNkHlqzqXYoVezqQoD8wfNi4trE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199018)(83380400001)(33656002)(478600001)(54906003)(55016003)(921005)(110136005)(38100700002)(122000001)(38070700005)(316002)(186003)(71200400001)(6506007)(52536014)(64756008)(26005)(7696005)(9686003)(66476007)(66946007)(7416002)(66556008)(44832011)(5660300002)(66446008)(86362001)(4326008)(8936002)(8676002)(76116006)(41300700001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AOz6nfHUKM2pMlb5d5Ynaynp8Lyy+3R7Wve7R47/k02i1gyRzXKJGL3QPRrn?=
 =?us-ascii?Q?6BWePztDSV5U3sl7v9S7t0Yf9Af05Awvy3nHRvhhQhPlbgIgRsBSSVG/fdDL?=
 =?us-ascii?Q?+4XsByWplG3lEPc6fqSJYHJjuWH4FfnuIMEy0nHc8KebqA1rIV6KbODqVzbF?=
 =?us-ascii?Q?xEHMJZiibwq24+el2twJ+rMyeg+EfwoVENwPgW5Kng596R0vkfVhJVTd/2y6?=
 =?us-ascii?Q?LNQuFo+Eti09gT/cMuK5WK13slsBTtlXvQ9Ql2kXOlcOdxN55jERITYhq0Jj?=
 =?us-ascii?Q?XyrAHbLxFZ/Z6HppgONF9bG+SOXwsBbNQRNpf7qAFuO71fMCbRrDxzQzSAo/?=
 =?us-ascii?Q?i2JrudF+W+vMscSZTRmx+eMfhHarJrWOKDO+DcZl2XR3gRUqmc7Pw/O4q7tm?=
 =?us-ascii?Q?RK6sClx2eRwx2bX1VQTw3XEHRtezOQ7jnHW1YeBfKJgg603FzfAOL1eMvPoa?=
 =?us-ascii?Q?BP5Q2sByWhzSKPioWVtYOPbw7uJGZDwIZ2h8ZRB7jAgTuMRJ1/CdNhhTvCAJ?=
 =?us-ascii?Q?k5I4N0t9G6Dl8txCzaRa/Rbv4nZOnRIH7n2nAHiaFsDruQq9LhpWfoRYRal8?=
 =?us-ascii?Q?X3uk561zR5/lHwaimJ5UsosxBYvU+A00JG8k/SpJW6WXhU5Iz1LUijWTzMAj?=
 =?us-ascii?Q?/qtXGx5JEtfNFtm+8vIdXHkCQ69c38PFUVH05Kh+Gclx6RHC9/nD9oYgWcX3?=
 =?us-ascii?Q?94BBxed8MSJi+q/+h7D2EUvPjpvIuNPldwP63aLoTCVX+nQ6bN2X4fbygrQU?=
 =?us-ascii?Q?2iSRVqXPGC1a++zpEgCryEka70ZJVW8cyNQBFa+4/t5DYkkECx1OELO0pX0/?=
 =?us-ascii?Q?tRfBfcERBGFC0d2Ud9pE0uNDvjUtfumLPtD97H4TT2QRCy1nW7relmox8J3U?=
 =?us-ascii?Q?+ykLcnaNCyJtuRAIUnD5kNdgpwp7FSmeyWTkoAkIeuJUlvn8zkwjST3lh5os?=
 =?us-ascii?Q?F/1erlPE2aDWCM6QjuSn7/SThnGaO+0L+MDBPIIYjE9+YF9fdJsOLDamsHQi?=
 =?us-ascii?Q?/w2j7KC3cbrnveAMalLe5/rC6dzTqOdwyMhJvSkElHNPtzUAFOstJuNcQQU0?=
 =?us-ascii?Q?/BOBBPyeDKVtg3kQayW3sO23NmO2trXyTLn2WTj8RdQVUpi/T2h6o0bV/0lx?=
 =?us-ascii?Q?Rq2GRLZ7+O54sHEBQrHm1yTr5tWQ1iuADlWVF0YQl3sGqIMdhT41K8YUElmr?=
 =?us-ascii?Q?GS8YxQkOlT5v9dpNE2RwSjEZSYQT5buGCvtRp75lOr/7y4btj5RdHcaBSWSL?=
 =?us-ascii?Q?o5QsBuTjUi0TznYZe+j54PEykZAENb3shJ+vIqX3+5g8GWFiRQFn7+6M2To1?=
 =?us-ascii?Q?IIhQE3mXFFY2Da/Yf9HQx/tdIINBdFvmkSlSp8FyJPiOICfbwrSoIchCsdnx?=
 =?us-ascii?Q?kfF7JvAGiBnWojxS/VEB3roP7WNk/UDtXXxNJ6LmEUYkSl2sOoCC6bIFZbQ4?=
 =?us-ascii?Q?/Dcs60LWfiWXlxw1kVZn00KpfQhk3E+7i/eutgrBkoKNMV0AmGOQpxQK4lyf?=
 =?us-ascii?Q?RLxQIsXZ+un/1bon1ocjVRlmkIDh+R3Wggc4w535Htjxw6LJy4MgJq9F4DJn?=
 =?us-ascii?Q?oeeBcGd6RtcwKwuxFaY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b135925-5dce-4ff5-f866-08db24315820
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 02:10:55.2985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: btl8Sx43NVVw3lgcg2J98hkw69Y3vkTQSLDMUSeXtGHS7VXVJDi8Gk8/O9l6ek5k4t9HPQvJQmkN2zO3KrB7Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9561
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Using a bitmap to get vb2 index will allow to avoid holes in the indexes w=
hen
>introducing DELETE_BUF ioctl.
>
>Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>---
> .../media/common/videobuf2/videobuf2-core.c   | 22 ++++++++++++++++++-
> include/media/videobuf2-core.h                |  6 +++++
> 2 files changed, 27 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/media/common/videobuf2/videobuf2-core.c
>b/drivers/media/common/videobuf2/videobuf2-core.c
>index 96597d339a07..3554811ec06a 100644
>--- a/drivers/media/common/videobuf2/videobuf2-core.c
>+++ b/drivers/media/common/videobuf2/videobuf2-core.c
>@@ -397,6 +397,22 @@ static void init_buffer_cache_hints(struct vb2_queue
>*q, struct vb2_buffer *vb)
>                vb->skip_cache_sync_on_finish =3D 1;  }
>
>+/*
>+ * __vb2_get_index() - find a free index in the queue for vb2 buffer.
>+ *
>+ * Returns an index for vb2 buffer.
>+ */
>+static int __vb2_get_index(struct vb2_queue *q) {
>+       unsigned long index;
>+
>+       index =3D bitmap_find_next_zero_area(q->bmap, q->idx_max, 0, 1, 0)=
;
>+       if (index > q->idx_max)
>+               dprintk(q, 1, "no index available for buffer\n");
>+
>+       return index;
>+}
>+
> /*
>  * __vb2_queue_alloc() - allocate vb2 buffer structures and (for MMAP typ=
e)
>  * video buffer memory for all buffers/planes on the queue and initialize=
s the
>@@ -423,7 +439,7 @@ static int __vb2_queue_alloc(struct vb2_queue *q,
>enum vb2_memory memory,
>                vb->state =3D VB2_BUF_STATE_DEQUEUED;
>                vb->vb2_queue =3D q;
>                vb->num_planes =3D num_planes;
>-               vb->index =3D q->num_buffers + buffer;
>+               vb->index =3D __vb2_get_index(q);
>                vb->type =3D q->type;
>                vb->memory =3D memory;
>                init_buffer_cache_hints(q, vb); @@ -2438,6 +2454,9 @@ int
>vb2_core_queue_init(struct vb2_queue *q)
>        mutex_init(&q->mmap_lock);
>        init_waitqueue_head(&q->done_wq);
>
>+       q->idx_max =3D ALIGN(256, BITS_PER_LONG);
>+       q->bmap =3D bitmap_zalloc(q->idx_max, GFP_KERNEL);
>+

Hi Benjamin,

    Does it mean the maximum vb2 buffer count is enlarged to 256?
    What will happen if user create the 257th buffer?

Ming

>        q->memory =3D VB2_MEMORY_UNKNOWN;
>
>        if (q->buf_struct_size =3D=3D 0)
>@@ -2465,6 +2484,7 @@ void vb2_core_queue_release(struct vb2_queue *q)
>        mutex_lock(&q->mmap_lock);
>        __vb2_queue_free(q, q->num_buffers);
>        mutex_unlock(&q->mmap_lock);
>+       bitmap_free(q->bmap);
> }
> EXPORT_SYMBOL_GPL(vb2_core_queue_release);
>
>diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-
>core.h index 47f1f35eb9cb..4fddc6ae9f20 100644
>--- a/include/media/videobuf2-core.h
>+++ b/include/media/videobuf2-core.h
>@@ -561,6 +561,8 @@ struct vb2_buf_ops {
>  * @dma_dir:   DMA mapping direction.
>  * @allocated_bufs: list of buffer allocated for the queue.
>  * @num_buffers: number of allocated/used buffers
>+ * @bmap: Bitmap of buffers index
>+ * @idx_max: number of bits in bmap
>  * @queued_list: list of buffers currently queued from userspace
>  * @queued_count: number of buffers queued and ready for streaming.
>  * @owned_by_drv_count: number of buffers owned by the driver @@ -
>624,6 +626,8 @@ struct vb2_queue {
>        enum dma_data_direction         dma_dir;
>        struct list_head                allocated_bufs;
>        unsigned int                    num_buffers;
>+       unsigned long                   *bmap;
>+       int                             idx_max;
>
>        struct list_head                queued_list;
>        unsigned int                    queued_count;
>@@ -1259,6 +1263,7 @@ static inline struct vb2_buffer
>*vb2_get_buffer(struct vb2_queue *q,  static inline void vb2_set_buffer(st=
ruct
>vb2_queue *q, struct vb2_buffer *vb)  {
>        list_add_tail(&vb->allocated_entry, &q->allocated_bufs);
>+       __set_bit(vb->index, q->bmap);
> }
>
> /**
>@@ -1268,6 +1273,7 @@ static inline void vb2_set_buffer(struct vb2_queue
>*q, struct vb2_buffer *vb)
>  */
> static inline void vb2_del_buffer(struct vb2_queue *q, struct vb2_buffer =
*vb)
>{
>+       __clear_bit(vb->index, q->bmap);
>        list_del(&vb->allocated_entry);
> }
>
>--
>2.34.1

