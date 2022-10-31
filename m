Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6E06136DB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 13:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiJaMsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 08:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiJaMsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 08:48:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EE3EE15;
        Mon, 31 Oct 2022 05:48:50 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 48DEA6602387;
        Mon, 31 Oct 2022 12:48:48 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667220528;
        bh=ETLcOC6RqGvMLvwInB/+hn555B0YojoNFYRHkoq15ys=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IVJTu5Kmw6Bx3dBbjqANAxFC42H8FCVyp7y5hDD88QU6z/8dffprYyNN7wg7NfQlL
         VPdKu/AIXrBedGLMVMl3rUzDrlqCQqD2ZqcwvNUO0UcAiUTm6wZgH7CQaa4Fg+KQUi
         r1SkLpU5f9hR4yku37q7q8UdrVoV15MFT0mPGwUoM+ReQhPO+Yb8Xxqh/gQ6whADPm
         zXBQiS24Qsl81Jhx19reqEmL47I7O4vR5T0QqaKuR14Ufy0/VKJ3wWW1kVlaMmgXGR
         XlKzP9qSY8bWQjxIwh9B3zgiUqYpeWlqLdnFbnqyxS0ML3bvk1kDRl+C02Q7/uOLvP
         ijCjc4NCnI0iw==
Message-ID: <2fbf35b9-3cad-4211-db5b-501d5eb14a2e@collabora.com>
Date:   Mon, 31 Oct 2022 13:48:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] vcodec: mediatek: add check for NULL for
 vsi->frm_bufs[vsi->new_fb_idx].buf.fb in vp9_swap_frm_bufs
Content-Language: en-US
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Anastasia Belova <abelova@astralinux.ru>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, lvc-project@linuxtesting.org
References: <20221028125811.11340-1-abelova@astralinux.ru>
 <664bd195bdde7fd740572c4981c60b32de1465aa.camel@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <664bd195bdde7fd740572c4981c60b32de1465aa.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/10/22 15:02, Nicolas Dufresne ha scritto:
> Hi,
> 
> Le vendredi 28 octobre 2022 à 15:58 +0300, Anastasia Belova a écrit :
>> If vsi->frm_bufs[vsi->new_fb_idx].buf.fb == NULL while cleaning
>> fb_free_list NULL-pointer is dereferenced.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Fixes: f77e89854b3e ("[media] vcodec: mediatek: Add Mediatek VP9 Video Decoder Driver")
>>
>> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
>> ---
>>   drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c
>> index 70b8383f7c8e..b0679aaf6192 100644
>> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c
>> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c
>> @@ -512,7 +512,7 @@ static void vp9_swap_frm_bufs(struct vdec_vp9_inst *inst)
>>   	 * clean fb_free_list
>>   	 */
>>   	if (vsi->frm_bufs[vsi->new_fb_idx].ref_cnt == 0) {
>> -		if (!vp9_is_sf_ref_fb(
>> +		if (vsi->frm_bufs[vsi->new_fb_idx].buf.fb != NULL && !vp9_is_sf_ref_fb(
>>   			inst, vsi->frm_bufs[vsi->new_fb_idx].buf.fb)) {
>>   			struct vdec_fb *fb;
> 
> Perhaps we could try and maintain some readability ? I'd suggest to move the
> check into vp9_is_sf_ref_fb() as an early return.
> 

I don't think that this will ever happen, as the check was omitted because of being
totally sure that vsi->frm_bufs[vsi->new_fb_idx].buf.fb is not NULL.

In any case, it doesn't really cost anything to add a check... in which case, I
agree with Nicolas about moving that to vp9_is_sf_ref_fb().

	if (!fb)
		return false
	for .....

Regards,
Angelo

