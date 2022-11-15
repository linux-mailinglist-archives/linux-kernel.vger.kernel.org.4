Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BC2628F05
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 02:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiKOBPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 20:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbiKOBPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 20:15:25 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550CF140B4;
        Mon, 14 Nov 2022 17:15:24 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o7so11943733pjj.1;
        Mon, 14 Nov 2022 17:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hB5Kxtwkzy2WQ2B6FnTtD5MnijvpxL0Nr18t1+rbyuI=;
        b=X0BAYPLGZC6QLMCHKDZ+9jlyLGC2tKlNDJ2qkNuliDg+2TxYVO7lkUn78qE4ptrp0r
         oH0qWTB4bTXzPCNpVBKIEf8QM4VarlNLG4+nR0x24UtjMljvEtIdHUzirNv/ul1cIR3b
         mLm8CXetvxB7ABJ0VRqmPpA/EPnjYsB+iRNTh2066ETdCj9ndsg8msUwf+g34+49WSiv
         4Xh3U8yYDDqVmbKkf2Pj2std0A98eCfVcJG5OPhe6OueEl5y47IuSVea1seetuGG6NHi
         kKBXE2qiHcVRa1GiNcEiIjbko11rv8f57Rp44upjlEcNFlW9OfDbvNyGrxk6/WI35+XR
         Tezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hB5Kxtwkzy2WQ2B6FnTtD5MnijvpxL0Nr18t1+rbyuI=;
        b=PD6hs/Qa7yvmWBDLk+HUrYApFbyE/GhE0Qr5gUF2x+oehDKEgBURFkcgT2NmHCfgq6
         8bH+Knv3vFVng9ugGylWubjiuVNdJwJfot/akEzVYbTnF3ARhvkiZMgp7xmegWUngMDp
         3LLwLT43x4L1lFbpMaWg4iUl3XVddm3tbDWwLVxYV4gQdGOgQEger0Iwbp75ehht6iZT
         X2BpD2tDxu8pHOcNrFwG5o8o3kFMF6P2nJzuT3C/ipEXJ0BVtNlMCQAxdkyodhgDbaEP
         qj6ebm9RLk5Vw0oW4RhyNsJi2O5JIZfpC/wzc+vfS/ztjG+TMrfqnBuJX+vr8LDBBoA2
         ff+w==
X-Gm-Message-State: ANoB5pmipA0qctGyw5kO3MVKCLDtvBunasxmzK8SWU6fLjagOL16Sk/Q
        8WcvK+dKkg+vNphFlKsQGX8=
X-Google-Smtp-Source: AA0mqf652OGjmHkx+nSTAsYgDw7Kr/ZKqZIw8v4TGdrpx2sY1yn63zY7cHinmrWY1R0cl0zOcNm2Vw==
X-Received: by 2002:a17:902:f790:b0:186:6180:fb89 with SMTP id q16-20020a170902f79000b001866180fb89mr1632383pln.142.1668474923457;
        Mon, 14 Nov 2022 17:15:23 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:718:95ee:2678:497])
        by smtp.gmail.com with ESMTPSA id t6-20020a170902e84600b001785fa792f4sm8280725plg.243.2022.11.14.17.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 17:15:22 -0800 (PST)
Date:   Mon, 14 Nov 2022 17:15:19 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, w.david0@protonmail.com,
        stephan@gerhold.net, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v4 3/5] Input: msg2638 - Add support for msg2138
Message-ID: <Y3LoJ6KketQZAXvM@google.com>
References: <20221110171952.34207-1-vincent.knecht@mailoo.org>
 <20221110171952.34207-4-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110171952.34207-4-vincent.knecht@mailoo.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 06:19:46PM +0100, Vincent Knecht wrote:
> msg2138 only supports 2 fingers presses, and needs different processing
> since second finger press is encoded as a delta position wrt. first one
> and the packet/touch_event structs are not the same as msg2638.
> 
> Add support for it by implementing distinct structs and irq handler.
> 
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>

Applied, thank you.

-- 
Dmitry
