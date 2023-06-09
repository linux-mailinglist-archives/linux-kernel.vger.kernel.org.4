Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E51A729FAF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242065AbjFIQKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241511AbjFIQKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:10:18 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F8E30D6;
        Fri,  9 Jun 2023 09:10:17 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-77ac59135ebso84629639f.3;
        Fri, 09 Jun 2023 09:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686327017; x=1688919017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zd94wwjNm5lzAbgn1yoGEBqb6vodjF1zy+V+iYm+O84=;
        b=GfQbMBb5NH5u1dgYPWOSrmvX3Q65JXBAc0UsxTp0WYn0PuvuZeFfOvNHILkcVHhcfZ
         t681VXGCXWX/6Gd02PmdLl1yp1HRA5aL1zsrjsyQJUft0NIxKNdTtu0h+Km4uFVtv05b
         paRO8oEpqFbFeGMxTC6kGCFzc1Bsip2XWeyVRx67nLeSLgyNiGDMU79sPZcCJR+NF9x9
         MmKYlOpb0RkA2VsXdR/+pl68WjcuCkDD17oleQjHKQcfo7KrFhecjR67w3lLiSM6qH4I
         zEKoAb8bq6EHZlvHHWfy1KWIhH9PT2ECEXwwGmZBaqIANLLAw7NwL5+eMIwGFrRpW2TS
         nUZQ==
X-Gm-Message-State: AC+VfDyiBXb54LQ3wpIJWioJDy+Ef1fGbqyY+4GyBKXAMRCy+azGxVjr
        SiQttTLJpr0BFiavO4RzAg==
X-Google-Smtp-Source: ACHHUZ5aby7i6WNeqG7cRySeJ0rvFhKrIopPGxiceV4GEP9w3UVUAGbb26dgZS2yB99aNdU6PZToBQ==
X-Received: by 2002:a5e:8301:0:b0:762:f8d4:6f4 with SMTP id x1-20020a5e8301000000b00762f8d406f4mr2026408iom.8.1686327016950;
        Fri, 09 Jun 2023 09:10:16 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id y2-20020a02a382000000b00411b8c1813asm1022248jak.159.2023.06.09.09.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 09:10:16 -0700 (PDT)
Received: (nullmailer pid 1163931 invoked by uid 1000);
        Fri, 09 Jun 2023 16:10:13 -0000
Date:   Fri, 9 Jun 2023 10:10:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org, hsinyi@google.com,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        yangcong5@huaqin.corp-partner.google.com,
        linux-arm-msm@vger.kernel.org,
        Chris Morgan <macroalpha82@gmail.com>
Subject: Re: [PATCH v2 04/10] of: property: fw_devlink: Add a devlink for
 panel followers
Message-ID: <20230609161013.GA1149945-robh@kernel.org>
References: <20230607215224.2067679-1-dianders@chromium.org>
 <20230607144931.v2.4.Ibf8e1342b5b7906279db2365aca45e6253857bb3@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607144931.v2.4.Ibf8e1342b5b7906279db2365aca45e6253857bb3@changeid>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 02:49:26PM -0700, Douglas Anderson wrote:
> Inform fw_devlink of the fact that a panel follower (like a
> touchscreen) is effectively a consumer of the panel from the purposes
> of fw_devlink.
> 
> NOTE: this patch isn't required for correctness but instead optimizes
> probe order / helps avoid deferrals.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> Since this is so small, I'd presume it's OK for it to go through a DRM
> tree with the proper Ack. That being said, this patch is just an
> optimization and thus it could land completely separately from the
> rest and they could all meet up in mainline.
> 
> Changes in v2:
> - ("Add a devlink for panel followers") new for v2.
> 
>  drivers/of/property.c | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
