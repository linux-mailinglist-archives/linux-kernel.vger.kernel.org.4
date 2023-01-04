Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3A965DBF4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 19:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239912AbjADSOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 13:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbjADSOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 13:14:03 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B6B17E2B;
        Wed,  4 Jan 2023 10:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1672855886; bh=QAtVPb8/maBAbEqyYYU7IL6BXcXNEnFbxuu32oqJJJI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ANgi4/tnT+LdcOQfKXgDnOzpKxKHZajftGHzP36ewHMDwUsc8LOpFG11eZQAVYUkm
         effb8tGWZecMTmwsiw41ptMcbturL4t7yuO3L9MFOV/rBqdXxZp0uLdPWptEsmr512
         ig3vEBmwMXFLSoAKTIYYUK5froS9xZyhZLZOyldxSa1kqdUEOCOTTqo3wUxqFaE1sx
         gvZYZqgH6L+Vph8ZuoerFfvit8e89Jqm24VsyHzLrQzEQy3m3OhJCnPHgrVMXlMsVq
         LqQmy7DK2SYpfAQjEFAJaY9kh3jjgsO65dmcK4rrWZiGZ/angNVI/cn7pWyGA3eQ+6
         Dsjnr6i37i2Dw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.135.20]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2V0H-1onx0z2eI3-013uIe; Wed, 04
 Jan 2023 19:11:26 +0100
Message-ID: <a187d1a7-fdf4-560f-7b04-7b050adeae26@gmx.de>
Date:   Wed, 4 Jan 2023 19:11:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] fbdev: omapfb: avoid stack overflow warning
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221215170234.2515030-1-arnd@kernel.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20221215170234.2515030-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o7jEKVSLoyMQ1mu2kGuybgdfN422oA9LLfcwWrY3jDvf/72dkTw
 jkaB7DZ6/dKNZJeUACKaGCerZFkZzKeinztdfPrjENYIhQF5e5Tquucglcilg/c9JiTzHiB
 BJS3CcM5hD5LrAliUQML2Mu03+ZCPNd873aeH3FUsmZpAd9q9kRw6HQKSyCeffRnAeZKe1E
 8CeAvs8XdZHlA7/lR+mkA==
UI-OutboundReport: notjunk:1;M01:P0:YgyS5b8jd1Q=;vIw3i+LL+6sOzRPYMEl2+prMT6/
 YDGpUzv1gD/paYtwpUTyIwnJ7uGHAbqXdKG/YQs+w3Wdx37hp7EhUP/YDg10F5seuvrGlHBHz
 wEMGMQ0tzZUVqi0pqYAmGXIvtvGptUtilRDE8ym2eJoAwyMKWOcruJJdCPC19sk5qxgHU5w0Z
 lmrPqsaG479PNncy7QxYwPDv9W6USNiTJPLY1qp1RtA0hn5Pe2r6T/n3SRMiszhoKiXLmcaQX
 53/twgXarfEKVesSYB/ncJSPbeRoUO1FkAOTxS6EFKIeR67Gsmqg55xnuWUD3nraMotvu1Eo4
 Hsz01Vpp+K/iUUJZEh+ef68nGDsftNNyixSP9F9JXPXiKxslKwHPGmqd03M9LSeKoofG5VJYT
 YlUg0hQgc6EQjKOVs+WC6T/NM8RvbK8Bhh6gd6JTJy2S0MXkN2fO//Sa6mqs0OOc7EnrgN4W2
 jevDroifZeZO/57eI9Gtt+7u4gSXHKPI/y+9p7/0k64QZTn2tkKfXLBsrOqJ91LQy8Exqa0vV
 W+CCe2Jwk47O5i8y2JcBPSPv7bliRDHYXYFY0CwO9AVxwn88F59EDnWwzXKvzVZWgTdAxxBwi
 IfoT4aQyNlYr4EztXzsyrWDLSnYFnkrK1d2Um/4fWNe7feSK/2GYIoNOP6pMS2jLGDBocagvG
 6qYLGfwS6WAMmfIdHUKFqIhP8JASzoHbdKxMq3bYGmR9mCr8qqhPISLPeop9kjiIeIIm1se9d
 cBGpQFpklEqj7TzLyYwu6TYnFdEjS9M1D5p93+gg/pivRmoJ1jw1tAmIGOQgNnWHCN03B39j8
 Y6YezNLnVLxZ7vOaz8ACW6C2juM5wG3SCBIknqhuz5OhEDnfyZU+2hSUF9cxc64n3oj2Ae0r+
 Fx46LrxSaqPWA6UuYboGMyiuLuRHMUmQnTpqj3pVISBVg2R9wpRcuNIsbJjDsBL2W+XZsBw66
 9ptsJA==
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/22 18:02, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The dsi_irq_stats structure is a little too big to fit on the
> stack of a 32-bit task, depending on the specific gcc options:
>
> fbdev/omap2/omapfb/dss/dsi.c: In function 'dsi_dump_dsidev_irqs':
> fbdev/omap2/omapfb/dss/dsi.c:1621:1: error: the frame size of 1064 bytes=
 is larger than 1024 bytes [-Werror=3Dframe-larger-than=3D]
>
> Since this is only a debugfs file, performance is not critical,
> so just dynamically allocate it, and print an error message
> in there in place of a failure code when the allocation fails.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

applied to fbdev git tree.

Thanks!
Helge

> ---
>   drivers/video/fbdev/omap2/omapfb/dss/dsi.c | 28 ++++++++++++++--------
>   1 file changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c b/drivers/video/=
fbdev/omap2/omapfb/dss/dsi.c
> index 54b0f034c2ed..7cddb7b8ae34 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
> @@ -1536,22 +1536,28 @@ static void dsi_dump_dsidev_irqs(struct platform=
_device *dsidev,
>   {
>   	struct dsi_data *dsi =3D dsi_get_dsidrv_data(dsidev);
>   	unsigned long flags;
> -	struct dsi_irq_stats stats;
> +	struct dsi_irq_stats *stats;
> +
> +	stats =3D kzalloc(sizeof(*stats), GFP_KERNEL);
> +	if (!stats) {
> +		seq_printf(s, "out of memory\n");
> +		return;
> +	}
>
>   	spin_lock_irqsave(&dsi->irq_stats_lock, flags);
>
> -	stats =3D dsi->irq_stats;
> +	*stats =3D dsi->irq_stats;
>   	memset(&dsi->irq_stats, 0, sizeof(dsi->irq_stats));
>   	dsi->irq_stats.last_reset =3D jiffies;
>
>   	spin_unlock_irqrestore(&dsi->irq_stats_lock, flags);
>
>   	seq_printf(s, "period %u ms\n",
> -			jiffies_to_msecs(jiffies - stats.last_reset));
> +			jiffies_to_msecs(jiffies - stats->last_reset));
>
> -	seq_printf(s, "irqs %d\n", stats.irq_count);
> +	seq_printf(s, "irqs %d\n", stats->irq_count);
>   #define PIS(x) \
> -	seq_printf(s, "%-20s %10d\n", #x, stats.dsi_irqs[ffs(DSI_IRQ_##x)-1])
> +	seq_printf(s, "%-20s %10d\n", #x, stats->dsi_irqs[ffs(DSI_IRQ_##x)-1])
>
>   	seq_printf(s, "-- DSI%d interrupts --\n", dsi->module_id + 1);
>   	PIS(VC0);
> @@ -1575,10 +1581,10 @@ static void dsi_dump_dsidev_irqs(struct platform=
_device *dsidev,
>
>   #define PIS(x) \
>   	seq_printf(s, "%-20s %10d %10d %10d %10d\n", #x, \
> -			stats.vc_irqs[0][ffs(DSI_VC_IRQ_##x)-1], \
> -			stats.vc_irqs[1][ffs(DSI_VC_IRQ_##x)-1], \
> -			stats.vc_irqs[2][ffs(DSI_VC_IRQ_##x)-1], \
> -			stats.vc_irqs[3][ffs(DSI_VC_IRQ_##x)-1]);
> +			stats->vc_irqs[0][ffs(DSI_VC_IRQ_##x)-1], \
> +			stats->vc_irqs[1][ffs(DSI_VC_IRQ_##x)-1], \
> +			stats->vc_irqs[2][ffs(DSI_VC_IRQ_##x)-1], \
> +			stats->vc_irqs[3][ffs(DSI_VC_IRQ_##x)-1]);
>
>   	seq_printf(s, "-- VC interrupts --\n");
>   	PIS(CS);
> @@ -1594,7 +1600,7 @@ static void dsi_dump_dsidev_irqs(struct platform_d=
evice *dsidev,
>
>   #define PIS(x) \
>   	seq_printf(s, "%-20s %10d\n", #x, \
> -			stats.cio_irqs[ffs(DSI_CIO_IRQ_##x)-1]);
> +			stats->cio_irqs[ffs(DSI_CIO_IRQ_##x)-1]);
>
>   	seq_printf(s, "-- CIO interrupts --\n");
>   	PIS(ERRSYNCESC1);
> @@ -1618,6 +1624,8 @@ static void dsi_dump_dsidev_irqs(struct platform_d=
evice *dsidev,
>   	PIS(ULPSACTIVENOT_ALL0);
>   	PIS(ULPSACTIVENOT_ALL1);
>   #undef PIS
> +
> +	kfree(stats);
>   }
>
>   static void dsi1_dump_irqs(struct seq_file *s)

