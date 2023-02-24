Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E706A2263
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 20:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjBXTkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 14:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBXTkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 14:40:35 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567146A7A7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 11:40:34 -0800 (PST)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DDB4A6602FCE;
        Fri, 24 Feb 2023 19:40:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677267633;
        bh=dxJ9OwJ4Yxn8rFPNZc3Z2H2yHUtHPds38dpBl7vM/NU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=na0wWdZkVsc60hy1r5q3Wa/BCN8pIGwByZKv8BLqbtsjpLoO4uoQAfIAldSY3DgrG
         imeYM9EqwANCtSRBvRcUTEQxuGYHfoS7cOvobSD0j1rhLdW0UtQ+TB9J/SOpT4+oSX
         yiT4IJ3wLIUACNIY/Enzxgo9Y03hSwSu74w6m7Pdgqz2MyoN4ASwTZVuaS6rWRKkuP
         Oos1jhht2gOWvBdXxj4+PPN6ptfcneJMDdVFqwFhal13bLK3+OnQ1OzzX2NoOqgvv5
         XD+oa/JoLkVeCPeiLexOi4XD1tJKEzC0XxYNSGsvoWSY5nW/s3Oc9xzbkNnJKS1Y+m
         qYMCjlg0Dvpag==
Date:   Fri, 24 Feb 2023 14:40:27 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] ASoC: mt8192: Fixes from initial glance at kselftest
 run
Message-ID: <20230224194027.fmazqn5wx6lhbw5u@notapiano>
References: <20230223-asoc-mt8192-quick-fixes-v1-0-9a85f90368e1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230223-asoc-mt8192-quick-fixes-v1-0-9a85f90368e1@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 02:03:54PM +0000, Mark Brown wrote:
> This is a collection of fixes I came up after glancing through an
> initial test run with the Spherion Chromebook on KernelCI.  There are
> more issues flagged, this is just what I fixed thus far - the volume
> controls on the MT6359 have issues for example, and a lot of controls
> aren't marked as Switches like they should be.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Thanks for the fixes.

Tested on a spherion chromebook to make sure audio still works as expected, and
the following tests from mixer-test in the alsa kselftest are fixed:

	# No event generated for MTKAIF_ADDA6_ONLY Switch
	not ok 1910 event_missing.0.13

	# No event generated for MTKAIF_DMIC Switch
	not ok 1917 event_missing.0.12

	# No event generated for Sidetone_Positive_Gain_dB
	# Sidetone_Positive_Gain_dB.0 value -1 less than minimum 0
	# Sidetone_Positive_Gain_dB.0 value 101 more than maximum 100
	not ok 1930 write_invalid.0.10

(no change in pcm-test results)

So,

Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas
