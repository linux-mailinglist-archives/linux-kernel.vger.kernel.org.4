Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F42970E77E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 23:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238647AbjEWVjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 17:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238619AbjEWVje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 17:39:34 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8868313E;
        Tue, 23 May 2023 14:39:31 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-253340db64fso196538a91.2;
        Tue, 23 May 2023 14:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684877971; x=1687469971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e8J4p6YIWy3rwiFFiWD8sVBLEWJtrwGY9Rb+6LKgbgU=;
        b=AyuLyEipYz70RrO0MkAQTcObYB3pgiVzGaOVUVjM7g4EKBmivjTls3n3OEMNeZMymF
         eHE8SbLPU1oZU8sBxg49f6r9b7BBVU8ZCiDjZqUfP5Ex1TJ22x4YjsBdjAPfpQjhpUyX
         72Nx2t7cyhst8QMZbmpAF/u7KYavR1ZtM9hL9daQ8yn2mPT088EViMVOPROBr3CD0Ueq
         Sk1Koe549LMl6oLWsHBENndJtIMpuE+rG/JPpNRs8wRId1kMM95oO5Qz9lE1r374O5tL
         EIIG70xlIlYEGACA42HIsHa5lKy8kPudJad1nWgIfMdZupH5gkPB0MyhZrp/NZ17i38B
         N/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684877971; x=1687469971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8J4p6YIWy3rwiFFiWD8sVBLEWJtrwGY9Rb+6LKgbgU=;
        b=FWe8UfUciwqgv8tcc4DS7FLt8zMlXvtAlFolwPyOahj2JAOJ3+VRC6o83tS6+/+Eb+
         ccLZCGoxbrEb+VCMjHkAI44/l8MVB3i3TzKpxa7YZp70pPJOkDWshwpESEgGJaABEop3
         eJvNW6yyYXg1dRc23Q01xYcEXSsa9lpvhknN1+8vKxDJ+o/3OAbm28r+nKQAtcqxxRC9
         3fSIyqM5l10yvckEnnhNDVcbwk/IJVDsb9BZTYCgTpaUhpCi7LoFbnlTbVcdp7V64EtP
         PmTePpADNzKjDxU81tAXZ2uqYFDU7nSZuwqO1d0X6smkjyo9AgdaeNSA74uFPeKjwcLg
         unhw==
X-Gm-Message-State: AC+VfDxdEOCLkLc6Ucsmv2QMIATeCQu5FzjO0GcKMepXMiK5co5d7O5P
        SMs81Tpqrj5V3mJLol+Cd8Q=
X-Google-Smtp-Source: ACHHUZ6a9iblkWuV5z76z2aSS5vYgHIkddjE5Muwt+iafdWTMh4nWbEJ/jsTonoYro5mB3RT38WsSQ==
X-Received: by 2002:a17:90a:ab08:b0:234:889f:c35d with SMTP id m8-20020a17090aab0800b00234889fc35dmr13881642pjq.3.1684877970802;
        Tue, 23 May 2023 14:39:30 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:3913:9c00:6a9e:2c95])
        by smtp.gmail.com with ESMTPSA id 21-20020a17090a01d500b0024e2980574asm49274pjd.4.2023.05.23.14.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 14:39:30 -0700 (PDT)
Date:   Tue, 23 May 2023 14:39:26 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
        hsinyi@google.com, devicetree@vger.kernel.org,
        yangcong5@huaqin.corp-partner.google.com,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org
Subject: Re: [PATCH 0/9] drm/panel and i2c-hid: Allow panels and touchscreens
 to power sequence together
Message-ID: <ZG0yjuNvhnircAxA@google.com>
References: <20230523193017.4109557-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523193017.4109557-1-dianders@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On Tue, May 23, 2023 at 12:27:54PM -0700, Douglas Anderson wrote:
> 
> The big motivation for this patch series is mostly described in the patch
> ("drm/panel: Add a way for other devices to follow panel state"), but to
> quickly summarize here: for touchscreens that are connected to a panel we
> need the ability to power sequence the two device together. This is not a
> new need, but so far we've managed to get by through a combination of
> inefficiency, added costs, or perhaps just a little bit of brokenness.
> It's time to do better. This patch series allows us to do better.

This seems to grow a new way of building relationship between panels and
associated devices. Can we make device_link_*() work for us?

Thanks.

-- 
Dmitry
