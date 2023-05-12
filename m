Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232AA700AC8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 16:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241609AbjELOzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 10:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241592AbjELOzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 10:55:01 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170F510E4D
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:54:43 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f417ea5252so52753215e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683903282; x=1686495282;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPibGk/VsIl1NlQ+E8IH62HD3HFwxeLmQ0A1sDyLGrY=;
        b=oTbQ0MBI8O99aP/PPw6jI4vWNvScQWUEVVtYJraANg7ALPnGNrbsQhOg/7BE6YG2DG
         knUbYfPO47MoKkrGI+Pa+q+z8MbVXxH6SJhAF7i1so2qVCuA2LCyOI+1QTPEbjKzPJuM
         mToXO0p38qTrWNcoAfZ9ZVAi7uBdR//OddKFxWOmf7PU5FIHQ4LKl7IFbSOn3aj+swha
         15IlcBrpedoTFLlctspWBEXrgz4JbBCHwEEKpFL9cTU1hMDkZDaKCTiGpP1X3SZQAd8E
         /Kt2rScCLy+3DJXp5l3IElEDnbd+foCmxd0FndbZzGfoBwmqnI/t9AAN+V46+3OGUYs5
         ekow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683903282; x=1686495282;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPibGk/VsIl1NlQ+E8IH62HD3HFwxeLmQ0A1sDyLGrY=;
        b=kAdkJg76YxT1wx5VMWPQf9Lq6yjGm5NzypFm7DOA0nEmdQau2AuMmKs9FP1VNDYbIi
         1JN1ShPuNrOrit+HfnC4xbTwmfTcvJGz5v7buQtOOPOXjminiUpvcJ8TDjltOasdelUB
         fh/6n5d+Bw99fkMrRxKBWhbCh2P9GD127IAX/xop4jmGffXNve/e7l0FZqRHEvHE1tj5
         he+NNx5BmN3/30yVpaXIHifYyRFkdWxlxRCO4JsqTbfZvK2Cf4Txy50DrCU0xJPQT7GT
         8m9qjqs5pzYoVvYHJ/KW5l5zoVa/SeP2Lxx/MCiM2tEkQkbbr+h29CY/SbzaQMwWH05Q
         Nazg==
X-Gm-Message-State: AC+VfDymfHbwPNBdnKr4HiWSGo8nMl5weP40dbt7ToITIR8nwC+2smfZ
        hmz/Qa4ozDVBCMzZ0ec44SusjA==
X-Google-Smtp-Source: ACHHUZ6CncOxg8qPy8qYrW4dm6HRCcDc6I/jklbEDF8sFnXgTK8ZuBSeeupPp/h25wntlT3Rp+dn2w==
X-Received: by 2002:a7b:cb53:0:b0:3f2:53a5:d308 with SMTP id v19-20020a7bcb53000000b003f253a5d308mr16833397wmj.6.1683903281792;
        Fri, 12 May 2023 07:54:41 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id v2-20020a1cf702000000b003f32f013c3csm28953540wmh.6.2023.05.12.07.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 07:54:41 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <jstultz@google.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tomi Valkeinen <tomba@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kernel@collabora.com
In-Reply-To: <20230406160637.541702-1-dmitry.osipenko@collabora.com>
References: <20230406160637.541702-1-dmitry.osipenko@collabora.com>
Subject: Re: (subset) [PATCH v2 0/7] Move dma-buf mmap() reservation
 locking down to exporters
Message-Id: <168390328031.185210.8399521458221830929.b4-ty@linaro.org>
Date:   Fri, 12 May 2023 15:54:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 06 Apr 2023 19:06:30 +0300, Dmitry Osipenko wrote:
> This patchset makes dma-buf exporters responisble for taking care of
> the reservation lock. I also included patch that moves drm-shmem to use
> reservation lock, to let CI test the whole set. I'm going to take all
> the patches via the drm-misc tree, please give an ack.
> 
> Previous policy stated that dma-buf core takes the lock around mmap()
> callback. Which meant that both importers and exporters shouldn't touch
> the reservation lock in the mmap() code path. This worked well until
> Intel-CI found a deadlock problem in a case of self-imported dma-buf [1].
> 
> [...]

Applied, thanks!

[4/7] fastrpc: Don't assert held reservation lock for dma-buf mmapping
      commit: 3f6b4c6f0bd0126f673f3578429239ae3860718b

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

