Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB19A6DCB70
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 21:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjDJTPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 15:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJTPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 15:15:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D711171C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 12:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681154071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V929y0DuvK7xtChWhUBw/eFqjVuZ3zFTuJadDMK7r9I=;
        b=P/F8ehYuVXRwObVrKbBbr3dH1EXhyKwBNPktBGkwtXLJtwgfXidlqEPvKFBfgIdtLbW/Eb
        GXl8EHfVzPwrbb/hMtY+ZOu4dGQjtn8V5FToeLqh68mMDySUfys85sMPs9BUhP/3k9AbIh
        CaBXucsMT7mehQcErbBjEHpNodqh8MU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-Wr9UP7VyNIe9GacCpfFspw-1; Mon, 10 Apr 2023 15:14:30 -0400
X-MC-Unique: Wr9UP7VyNIe9GacCpfFspw-1
Received: by mail-wm1-f70.google.com with SMTP id j14-20020a05600c1c0e00b003f066d2638aso4263036wms.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 12:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681154069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V929y0DuvK7xtChWhUBw/eFqjVuZ3zFTuJadDMK7r9I=;
        b=5xcb58yPxO4mydfg5z0FPkk4S3XrSqZ+wdfiaAn59tbsam0XYuOySBq9e0DK6gLhOX
         UjTK0X0DfMy/kQB2xQEG+GEktZTEn942kAWDy1xxqakOzoe9+6rmqgn7P6S1qE/AlOA2
         NXNxhEh8ct06iqNPhUcBX5ppxU6QETzcGQOuXux3D/mlGQwZ8Dul/cW0drPd/6Nzzg3J
         UG2e0gBYmN2u3nsHdU1Bh1OuDF0tFiOUm85Tfdu/zRyCvJBjwuiW+Fkv+tYCG1UkF3Tj
         6Nudh5EpV8p7Y/2PzVSkYMF4E0NZwY3eoU3b1PJOQ/tiYTT9+atHadIr4IxYuElKLiEf
         cyww==
X-Gm-Message-State: AAQBX9eCFrna+cS71u1r/SWwHv8aAa3H2SHFOsm9wrrhA+B6Y+2LpRIK
        ZhuTscR2h9rdfErwJeAvu2mgtQhl9h2dM466B5Rxd5g4Hwuvt+cvrWGBVW1WD67Es+4cI9N24YJ
        uzppVPCCm+OCsv6YqzBzz11b8
X-Received: by 2002:a5d:494c:0:b0:2c7:6bb:fb7a with SMTP id r12-20020a5d494c000000b002c706bbfb7amr6847039wrs.54.1681154069154;
        Mon, 10 Apr 2023 12:14:29 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZB01v4hRzyu7pDWRWnh2OLlh5MZFbKYbk/7NuN3PZ2CE4+XympLGJoeAWb/QCYhp3Tn3l29w==
X-Received: by 2002:a5d:494c:0:b0:2c7:6bb:fb7a with SMTP id r12-20020a5d494c000000b002c706bbfb7amr6847028wrs.54.1681154068798;
        Mon, 10 Apr 2023 12:14:28 -0700 (PDT)
Received: from redhat.com ([2.52.10.80])
        by smtp.gmail.com with ESMTPSA id e10-20020adfdbca000000b002ceac2ccc4asm12473201wrj.23.2023.04.10.12.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 12:14:28 -0700 (PDT)
Date:   Mon, 10 Apr 2023 15:14:24 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Alvaro Karsz <alvaro.karsz@solid-run.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] vdpa: solidrun: constify pointers to hwmon_channel_info
Message-ID: <20230410151317-mutt-send-email-mst@kernel.org>
References: <20230407150130.79917-1-krzysztof.kozlowski@linaro.org>
 <0395eff6-694e-1a2f-de78-8cb9d7b129a7@roeck-us.net>
 <20230410055634-mutt-send-email-mst@kernel.org>
 <2facc7cd-81fa-b8b7-6974-217392906578@roeck-us.net>
 <a6e07080-0c0d-0461-52a2-768d60af53c3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6e07080-0c0d-0461-52a2-768d60af53c3@linaro.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 06:48:12PM +0200, Krzysztof Kozlowski wrote:
> On 10/04/2023 16:03, Guenter Roeck wrote:
> > On 4/10/23 02:56, Michael S. Tsirkin wrote:
> >> On Fri, Apr 07, 2023 at 04:08:30PM -0700, Guenter Roeck wrote:
> >>> On 4/7/23 08:01, Krzysztof Kozlowski wrote:
> >>>> Statically allocated array of pointed to hwmon_channel_info can be made
> >>>> const for safety.
> >>>>
> >>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>>>
> >>>> ---
> >>>>
> >>>> This depends on hwmon core patch:
> >>>> https://lore.kernel.org/all/20230406203103.3011503-2-krzysztof.kozlowski@linaro.org/
> >>>>
> >>>> Therefore I propose this should also go via hwmon tree.
> >>>
> >>> I am not going to apply patches for 10+ subsystems through the hwmon tree.
> >>> This can only result in chaos. The dependent patch is available at
> >>>
> >>> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-const
> >>
> >> Doesn't it cause build errors or warnings there?
> >>
> > 
> > Are you saying that "hwmon: constify pointers to hwmon_channel_info" applied on its own
> > on top of v6.3-rc5 (as done in above branch) causes build errors or warnings ?
> > I have not seen any such reports, and I don't immediately see why that would be
> > the case. Please elaborate.
> 
> My tree and patches are extensively tested by kbuild and there was no
> warning reported (when the above patch is applied with above dependency).
> 
> Best regards,
> Krzysztof

I don't know, I assumed the vdpa patch fixes build. If not,
I think we can just wait with the vdpa patch until after
the hwmon one is upstream.

Thanks!


-- 
MST

