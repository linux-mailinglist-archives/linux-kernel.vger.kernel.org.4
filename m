Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FE36C4307
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjCVGW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjCVGWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:22:23 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2043.outbound.protection.outlook.com [40.107.6.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA12443924;
        Tue, 21 Mar 2023 23:22:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHCD5xUe2pNYxreyW1WMlHK2qfU/8v+P8OXITi20cAM66ytVkINKMtVueN4S3LyVbHOiwxMBmnNM8OPm9gRAoAQds7OinpIKjUJSsl1gl4NtSm8x/ID/yi9yjwMjpHx7eUnfN1mXnFwZytF7gNEFvxPdOXy2NvfnkiJJA5/hwfCpQJ0MWHmR81LwnqqvIe6JJqE6H7pZD6lJb3xPop1UiTt51hWq+xFQu1LsRnRUM6Ecwam/OLOlh+Ot3xAMh88G6Jw82cd9FDd329fb7Y7gUwC3RcK2G9Jz9cIazNP6oBNODtKf6FC4lL420Y2qxSJkArm3p1Nb3Wp21X+DoxybTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lge+UA3OxGZ51NXYzhwmQhnW/CsnGd32S5fmW+1uy5I=;
 b=YLyf9ohbmhrRCj3BK305YruoWA43feMDsAr+VedLSWFdEhtW6tQXxd5YbfWajOK6wAuLAj8bA4de0/jH0j+KGz/d56KEtEz446vpQAw70P47mbYUfYt+plCTb62Ao6WucEIvF0J2y60l3YMvU1RK+4JX4Yu5Ihw7vRZq+ea1f2qCFNKu5JN3zvvR4a44F2wJh4QQ3jxMifDvF3QZvsFh6tpjYIzduEZNfzTDZ8KRzPoBf7jRPC4SAdaRb3oVx5ejofzFMDr5AxPNxD2SKPccZNFrVphCxlWuEdnvsiwERhwcXz4ZlsA9BdJ7bEHNsUBzuHpXYuOeB5zu3QF4Z7Z9Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lge+UA3OxGZ51NXYzhwmQhnW/CsnGd32S5fmW+1uy5I=;
 b=TtBQ/5LhnjX8sPSyDuMsoHv453mH76gYwlJFLELg6GHrdxz7ekuNZwJoz/I907JnO+M1BTMJScbty5ViMPKe1aFKcFzFxhTK9lLD/bLifvdZZ5g0q6JxdwSSbEco8VKUuSkwn5jlUwx0IrSpEWCT6vXCeEmg3wyYTFyVQyTvla0=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AS8PR04MB8452.eurprd04.prod.outlook.com (2603:10a6:20b:348::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 06:22:16 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b%5]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 06:22:16 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        "tfiga@chromium.org" <tfiga@chromium.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
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
        "jernel@kernel.org" <jernel@kernel.org>
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
Subject: RE: [EXT] [PATCH v2 3/8] media: videobuf2: Add a module param to
 limit vb2 queue buffer storage
Thread-Topic: [EXT] [PATCH v2 3/8] media: videobuf2: Add a module param to
 limit vb2 queue buffer storage
Thread-Index: AQHZW9/61y4nj2LzfUipcFOEFe3NbK8GU++A
Date:   Wed, 22 Mar 2023 06:22:16 +0000
Message-ID: <AM6PR04MB6341CDD7A104C7BC6667C100E7869@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20230321102855.346732-1-benjamin.gaignard@collabora.com>
 <20230321102855.346732-4-benjamin.gaignard@collabora.com>
In-Reply-To: <20230321102855.346732-4-benjamin.gaignard@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6341:EE_|AS8PR04MB8452:EE_
x-ms-office365-filtering-correlation-id: e9c48ca2-9c23-4c42-ddba-08db2a9dc850
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w9X0m3t2LHin/ke2UnrjxJVUbD+EJURIWkYFBvnGiuKSep+d92IXnGzzka3yVKWM07YmNWrkTIrPXqbpQrmcI9TIAa2AnRaq3qaKePApPSsdZqw+n4WN4VER/pITX6cRVa9v3xE4Y1xQUjbW2TGJfKPJS0Ksg9HhTsgQXYri+rYQkqvyrdY7sahV/oGnr86KPkBqKeavbSvGEJOd/D1ClOdBC1gk1WjOw+FrEUS/jPOqRaefHRDB8bGGWJQQLEdctSBmbhsbgE1e2h+r4DgtEKhwaqFq7UZvcOR9B8guy2+kOH2+Ba2BaOxhk8kSQPvna42V+dDP/rpZ9DS2I15lB2qknnmLlEuLUZ+ub/ovElnQ7bB4xc4GMKRNFOYf5XKqMRby0fVVDTmguCW03KRKNIhV/mMjT8edBRygJx24BUYuWYL2HMZ5ttaUo66lodlkS02CnBUt0LuUKR/Vd5MhXSavoCBpokW3D4MDa7k5vaOKO/poi3D8XSeli3FyD/K4pN8TkGQrm+7Chvu2/IMdfuYyTfAyhCIeEp6lBIsW5PdQBi1inJLr5b+Tk75AhFnHLVK3q7cLk+t5kKARBvAdUZiJ1wlQhV+FGWJ7aQ/SlqABoPcYtvaYMqXNTCJCZcGLu8GeHt9MZYkMIPMmL6xpZBbSv9z9Dkwxr4LRnARtQFY3zvWQSDKtXUOWTTJBpf04vVBEAqvtImB1sTPg+tw2kH4ZbJTtCbEtjjff/3ZHf7Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199018)(186003)(9686003)(7696005)(478600001)(26005)(8676002)(6506007)(83380400001)(54906003)(71200400001)(110136005)(316002)(66556008)(66476007)(66446008)(64756008)(66946007)(76116006)(8936002)(52536014)(7416002)(5660300002)(41300700001)(122000001)(4326008)(2906002)(38100700002)(921005)(55016003)(86362001)(33656002)(38070700005)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9DZtGUHQvW/+ifC4Io8r81SRbdylzF8JHvOGXjt9A1GLhD1hA81e1WvW9mFl?=
 =?us-ascii?Q?L3C8K0kuo9Nxs8NtC6h7KMvg8XzdbaZQzu7sKVV6RuP7xBY5mUXC4nNWrfiI?=
 =?us-ascii?Q?0+A38fgPty4Bo85TMljYRC7ml+g7vOszUooOCIEFLcsxAGYR+xrjO2e+JRSS?=
 =?us-ascii?Q?pfzDYyb2bVqoPoWl1LRLLcmRrGqcmNAwlSoNMj6qKkgmosUZl0mdccDrs135?=
 =?us-ascii?Q?DhQvNeSEQ94Wi9u2liuRGufWAYzXrrZ75ITHmWHR5Doh3qNHgb/byX/sxlIQ?=
 =?us-ascii?Q?gEreYzRaadu8xV2bXrL3hlOkU4wqgmBgKdMRk3w94aRsIJT9O4GuM8Ozs3rn?=
 =?us-ascii?Q?++47GdBriAdfpqBX8O5UZDF6X2fbvU9tN5e39TUgVL94dYFU7tI6F+Y2Io8/?=
 =?us-ascii?Q?qNB7yiPFIW0+QbusE6RWvfzjT0+4SaRgPMbKKCsdZzGcXKf2UCL93UGD3qVM?=
 =?us-ascii?Q?q2/WB5HLkKI5j4RetBGSjT8Dv2Job0jENMStloMGmsZtcfquqww3pu1P97Vw?=
 =?us-ascii?Q?JFk7mfLa1R+UAJUOnH/Pya9QnBBH0qamw+F7dvTgi4tkLAntSgBx8kBxXbC9?=
 =?us-ascii?Q?V3zbm4qLhxkJjKXbgxJfn4Px4z9zu+2sDlSeUrqBUtiaUgAVctbA8quFuO51?=
 =?us-ascii?Q?UD4QikyaMKbW0b/I1QuvjS3rGboNp7siOGAn5vb8FqbEEXq7F9Ku4rZHG6Nc?=
 =?us-ascii?Q?w+UPw45esBGfiWonvrVjIm0pdHSPZpTy3iJ7cnX1Ru+RNG6S1y3JsDPjSNdM?=
 =?us-ascii?Q?P5Y21mWBiIhsKjMhPsM9OSBnjGTI+mC2ZVvd1AGp8cdSxmIlrpPww7L1xwZw?=
 =?us-ascii?Q?5rVloDMwBuKrTwqbIWZ8eSWGnbEXSt5aUFUWfkNb65YIinmwkNx2hkEZE7bY?=
 =?us-ascii?Q?gudKCo0L7mtWDki/b+kc4EK9WsRRqbdwErJ6kQZUDHYrg/LZn4m23y1jloLl?=
 =?us-ascii?Q?Xbqqfi6XrnoIlHVna7QfWWqCk0NUX9v4ruxYr66JbG4OcrbfWRm2g7urDzxF?=
 =?us-ascii?Q?AilaC4BKZCW2odi6qeWD3rbD102+nuhw+PfhDa4wYUM2ZIjLt/7tQmFQ4Rm9?=
 =?us-ascii?Q?YXS5nBbPCmEb5FNe9SPQcOMevScthEm9qg0whlmpJsBzBVSEj4P4ihcPs5pa?=
 =?us-ascii?Q?ITN6YX0uLXtG963cAULAhUwUA0klqr+QQcPYM7+GVvIC6Vwp0dAhJBGHhlFP?=
 =?us-ascii?Q?d29lmUcqqxs4gmev7KK3mJIp8AhVl79kAuILKEtzDBMgdhT2igvI/qouk8pm?=
 =?us-ascii?Q?d+/gyMeuWwkUFzw3jOi7me9kmvV4KzHWFdCr9M1HifQC0HK05CONKuUVSlp+?=
 =?us-ascii?Q?j2i/weBILb7EPxPJN6v69BOMdSEL3w7fNMscXcLYpuSXENV96Ztfjar5RwZX?=
 =?us-ascii?Q?VNrvd26LMT2x0p065+uH7JidX6iBrfIvIIdyemRuV6RF5UUjQKwvlTfcxpgn?=
 =?us-ascii?Q?Auc2dNQ+RfM+bV2ftBQB7gexqdpEhBK07h2orLrPEXnfX3KbuAW8CwL4xZur?=
 =?us-ascii?Q?FfhUyiFqIBGjDFBuaUyNkN7M882U+woJd458igrvfADbnmMLLFBBbXp7XQOo?=
 =?us-ascii?Q?1YK/hR/O8rndgXfEFSvGcu/AsgNNxTWKr/ePnlK3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c48ca2-9c23-4c42-ddba-08db2a9dc850
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 06:22:16.1407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6oBCK5TF5OpRZlFkmXQ0eS0udukgZFCkmWooqBFYbGuhOPLSbNPWPsjb9geyV3VkuZvzx0VI0H4KmOuFQjhrYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8452
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hi Benjamin,

>Add module parameter "max_vb_buffer_per_queue" to be able to limit the
>number of vb2 buffers store in queue.
>
>Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>---
> drivers/media/common/videobuf2/videobuf2-core.c | 15 +++------------
> include/media/videobuf2-core.h                  | 11 +++++++++--
> 2 files changed, 12 insertions(+), 14 deletions(-)
>
>diff --git a/drivers/media/common/videobuf2/videobuf2-core.c
>b/drivers/media/common/videobuf2/videobuf2-core.c
>index ae9d72f4d181..f4da917ccf3f 100644
>--- a/drivers/media/common/videobuf2/videobuf2-core.c
>+++ b/drivers/media/common/videobuf2/videobuf2-core.c
>@@ -34,6 +34,8 @@
> static int debug;
> module_param(debug, int, 0644);
>
>+module_param(max_vb_buffer_per_queue, ulong, 0644);
>+
> #define dprintk(q, level, fmt, arg...)                                 \
>        do {                                                            \
>                if (debug >=3D level)                                     =
\
>@@ -412,10 +414,6 @@ static int __vb2_queue_alloc(struct vb2_queue *q,
>enum vb2_memory memory,
>        struct vb2_buffer *vb;
>        int ret;
>
>-       /* Ensure that q->num_buffers+num_buffers is below VB2_MAX_FRAME
>*/
>-       num_buffers =3D min_t(unsigned int, num_buffers,
>-                           VB2_MAX_FRAME - q->num_buffers);
>-
>        for (buffer =3D 0; buffer < num_buffers; ++buffer) {
>                /* Allocate vb2 buffer structures */
>                vb =3D kzalloc(q->buf_struct_size, GFP_KERNEL); @@ -801,9 =
+799,7
>@@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>        /*
>         * Make sure the requested values and current defaults are sane.
>         */
>-       WARN_ON(q->min_buffers_needed > VB2_MAX_FRAME);
>        num_buffers =3D max_t(unsigned int, *count, q->min_buffers_needed)=
;
>-       num_buffers =3D min_t(unsigned int, num_buffers, VB2_MAX_FRAME);
>        memset(q->alloc_devs, 0, sizeof(q->alloc_devs));
>        /*
>         * Set this now to ensure that drivers see the correct q->memory v=
alue
>@@ -919,11 +915,6 @@ int vb2_core_create_bufs(struct vb2_queue *q,
>enum vb2_memory memory,
>        bool no_previous_buffers =3D !q->num_buffers;
>        int ret;
>
>-       if (q->num_buffers =3D=3D VB2_MAX_FRAME) {
>-               dprintk(q, 1, "maximum number of buffers already allocated=
\n");
>-               return -ENOBUFS;
>-       }
>-
>        if (no_previous_buffers) {
>                if (q->waiting_in_dqbuf && *count) {
>                        dprintk(q, 1, "another dup()ped fd is waiting for =
a buffer\n");
>@@ -948,7 +939,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum
>vb2_memory memory,
>                        return -EINVAL;
>        }
>
>-       num_buffers =3D min(*count, VB2_MAX_FRAME - q->num_buffers);
>+       num_buffers =3D *count;
>
>        if (requested_planes && requested_sizes) {
>                num_planes =3D requested_planes; diff --git
>a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h index
>397dbf6e61e1..b8b34a993e04 100644
>--- a/include/media/videobuf2-core.h
>+++ b/include/media/videobuf2-core.h
>@@ -12,6 +12,7 @@
> #ifndef _MEDIA_VIDEOBUF2_CORE_H
> #define _MEDIA_VIDEOBUF2_CORE_H
>
>+#include <linux/minmax.h>
> #include <linux/mm_types.h>
> #include <linux/mutex.h>
> #include <linux/poll.h>
>@@ -48,6 +49,8 @@ struct vb2_fileio_data;  struct vb2_threadio_data;  stru=
ct
>vb2_buffer;
>
>+static size_t max_vb_buffer_per_queue =3D 1024;
>+
> /**
>  * struct vb2_mem_ops - memory handling/memory allocator operations.
>  * @alloc:     allocate video memory and, optionally, allocator private d=
ata,
>@@ -1268,12 +1271,16 @@ static inline bool vb2_queue_add_buffer(struct
>vb2_queue *q, struct vb2_buffer *
>
>        if (vb->index >=3D q->max_num_bufs) {
>                struct vb2_buffer **tmp;
>+               int cnt =3D min(max_vb_buffer_per_queue, q->max_num_bufs *
>+ 2);
>+
>+               if (cnt >=3D q->max_num_bufs)
>+                       goto realloc_failed;
>

Is it likely that goto realloc_failed directly?
The cnt is likely equal to q->max_num_bufs * 2, and it will greater than q-=
>max_num_bufs.
For example, the default value of q->max_num_bufs is 32, when vb->index com=
es to 32, cnt is 64,  it's greater than 32, then goto recalloc_failed?

>-               tmp =3D krealloc_array(q->bufs, q->max_num_bufs * 2, sizeo=
f(*q-
>>bufs), GFP_KERNEL);
>+               tmp =3D krealloc_array(q->bufs, cnt, sizeof(*q->bufs),
>+ GFP_KERNEL);
>                if (!tmp)
>                        goto realloc_failed;
>
>-               q->max_num_bufs *=3D 2;
>+               q->max_num_bufs =3D cnt;
>                q->bufs =3D tmp;
>        }
>
>--
>2.34.1

