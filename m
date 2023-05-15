Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FC8702B18
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241180AbjEOLIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241163AbjEOLIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:08:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC521737;
        Mon, 15 May 2023 04:08:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6AA16227B;
        Mon, 15 May 2023 11:08:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBB3C433EF;
        Mon, 15 May 2023 11:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684148911;
        bh=olj9SocFR66EhLbf+VVLOl+zHXsxnZV4TDEkh6zL2MY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=q5ffqkbJfJH6tWfcBgdyCtzwgvmkFwV053vTKMs3YyZmiU5Y8p2btlgz4tGp8KF/R
         eQjK47v3+X3i222Euu8FijpFyP6Nux6pb+v4mqUszuRsT+9b8ebRl7RlQJguigbMDL
         BKqGQfmG0k1BT9oDUs2PSRk14FWIylwQf6mg3sDBQrMWhJePOaNOtmwK0T8pgA0GQE
         XczazgE+oqu70oDAJoBURTzKrgIdZVgPlKyQvEiypT1a8gZJtVLijr4AfSfRUqtWaa
         gu1sKTtNlutfPiEOJxu6ksFTDSE2WHfb1Eh2c20oLv+uQ/ujIemijRp4G9IL2eufEn
         THunG5weEt55A==
From:   Kalle Valo <kvalo@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Simon Horman <simon.horman@corigine.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexander Couzens <lynxis@fe80.eu>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Bo Jiao <bo.jiao@mediatek.com>,
        Nicolas Cavallari <nicolas.cavallari@green-communications.fr>,
        Howard Hsu <howard-yh.hsu@mediatek.com>,
        MeiChia Chiu <MeiChia.Chiu@mediatek.com>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Wang Yufen <wangyufen@huawei.com>,
        Lorenz Brun <lorenz@brun.one>
Subject: Re: [PATCH] wifi: mt76: mt7915: add support for MT7981
References: <ZF-SN-sElZB_g_bA@pidgin.makrotopia.org>
        <ZGD192iDcUqoUwo3@corigine.com>
        <ZGENDwGXkuhrCGFY@pidgin.makrotopia.org>
Date:   Mon, 15 May 2023 14:08:22 +0300
In-Reply-To: <ZGENDwGXkuhrCGFY@pidgin.makrotopia.org> (Daniel Golle's message
        of "Sun, 14 May 2023 18:32:15 +0200")
Message-ID: <87ednhn97d.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Golle <daniel@makrotopia.org> writes:

> On Sun, May 14, 2023 at 04:53:43PM +0200, Simon Horman wrote:
>> On Sat, May 13, 2023 at 03:35:51PM +0200, Daniel Golle wrote:
>> > From: Alexander Couzens <lynxis@fe80.eu>
>> > 
>> > Add support for the MediaTek MT7981 SoC which is similar to the MT7986
>> > but with a newer IP cores and only 2x ARM Cortex-A53 instead of 4x.
>> > Unlike MT7986 the MT7981 can only connect a single wireless frontend,
>> > usually MT7976 is used for DBDC.
>> > 
>> > Signed-off-by: Alexander Couzens <lynxis@fe80.eu>
>> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>> 
>> ...
>> 
>> > @@ -489,7 +516,10 @@ static int mt7986_wmac_adie_patch_7976(struct mt7915_dev *dev, u8 adie)
>> >  		rg_xo_01 = 0x1d59080f;
>> >  		rg_xo_03 = 0x34c00fe0;
>> >  	} else {
>> > -		rg_xo_01 = 0x1959f80f;
>> > +		if (is_mt7981(&dev->mt76))
>> > +			rg_xo_01 = 0x1959c80f;
>> > +		else if (is_mt7986(&dev->mt76))
>> > +			rg_xo_01 = 0x1959f80f;
>> 
>> Hi Daniel,
>> 
>> 		rg_xo_01 will be used uninitialised below if we get here
>> 		and neither of the conditions above are true.
>> 
>> 		Can this occur?
>
> No, it cannot occur. Either of is_mt7981() or is_mt7986() will return
> true, as the driver is bound via one of the two compatibles
> 'mediatek,mt7986-wmac' or newly added 'mediatek,mt7981-wmac'.
> Based on that the match_data is either 0x7986 or 0x7981, which is then
> used as chip_id, which is used by the is_mt7981() and is_mt7986()
> functions.

But what if later more changes are made, for example a third compatible
is added? It would be good to add a warning or something else to protect
that.

And I would not be a surpised if a compiler or static analyser would
even warn about the uninitialised variable.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
