Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22200634D7F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 02:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbiKWB4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 20:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbiKWB42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 20:56:28 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC75682A8;
        Tue, 22 Nov 2022 17:56:27 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so570738pjl.3;
        Tue, 22 Nov 2022 17:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iwQ+Ae7FcbFe/GyQX34Uo+D823BkM25C+bZq61zmpJQ=;
        b=SnVDVKcXzYYCXt/v6mhH2Gmzrfy2oHdsmoccdDd62UDoKR5/eRo49hhNGX0peEyRa9
         Gu3pl5MdGI6GtuNdMT6QFUCokS+hpTKXukSmUnxhprdvobWkzcOkt4OGE5IKmRKC+RD5
         sEtUdsgIW1aBnb/ClbuGPAIq5KQfM0LG3PmGLv6xZPGLpQVpey7ka1WDBH4aXZUnRbbh
         ouZygPxL0mfddffg+yEgQvM3EEwM5C/iXt7uvgTXMzFFOFeFyv+IDm5u4W+f4NDJC7gl
         fcWb6xMXWFd0Ois3v/m1nrp3HkQeEAdYD3601r9iZu2ItqOTXQ/x6EV0sj0wiW2ocEmi
         a3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iwQ+Ae7FcbFe/GyQX34Uo+D823BkM25C+bZq61zmpJQ=;
        b=yS8U3g/fjxAmZnTlvCHXIbQ8mhyE2mmZrGB+x7gTdgaizNOKhcgmeSuogcoW4pKzD5
         6aP6ucnrc3jgy7gRPbFaYccFyzVQtfK+M3NqcW1R4WGOCoAXsMPyDw6G3X5GQmgWKLgn
         YdrTJpNva7seHxdkRIoo+RgkaMxv6EHo4arG0zs249gw9NuTnyvyPyuI6IRHugiRJ23t
         cei6Ub1qlUNQn2ffobz02URlmNuNDDkQdS1QQxw+OTjHKm+iHIWIbSxYLOOVY8T2WTJH
         17jhartdr0wz24ANg6zCcXrIN5U7nOK5FPEkkXYHyVcta7UJ9MVEwOsV1f6K2h+fxKhC
         aSxA==
X-Gm-Message-State: ANoB5pnpphQGEtIi6uxM07wDZ4wPS63PYI/z1ZydoVuWZnsAQWNKOaCH
        Ysa4C4MFGVBpE7dHtPyDvsk=
X-Google-Smtp-Source: AA0mqf6z6tY5m4u6p51/gclPjqLMiQdNpZ0sFdQd2UQYcSoMHLIybMsWN7UmTTbWjA6xkdVl1fPyYA==
X-Received: by 2002:a17:902:b283:b0:186:be05:798e with SMTP id u3-20020a170902b28300b00186be05798emr6521981plr.37.1669168586793;
        Tue, 22 Nov 2022 17:56:26 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:af8d:6047:29d5:446c])
        by smtp.gmail.com with ESMTPSA id z11-20020aa79e4b000000b0056c0d129edfsm11286376pfq.121.2022.11.22.17.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 17:56:26 -0800 (PST)
Date:   Tue, 22 Nov 2022 17:56:22 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Eray =?iso-8859-1?Q?Or=E7unus?= <erayorcunus@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, ike.pan@canonical.com,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        mgross@linux.intel.com, pobrn@protonmail.com
Subject: Re: [PATCH v2 2/7] HID: add mapping for camera access keys
Message-ID: <Y319xtS7ZHKC2+ic@google.com>
References: <20221029120311.11152-1-erayorcunus@gmail.com>
 <20221029120311.11152-3-erayorcunus@gmail.com>
 <4f6e561b-12d7-0163-5f26-05d47a72d6cb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f6e561b-12d7-0163-5f26-05d47a72d6cb@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 09:33:49PM +0100, Hans de Goede wrote:
> Hi Dmitry,
> 
> On 10/29/22 14:03, Eray Orçunus wrote:
> > HUTRR72 added 3 new usage codes for keys that are supposed to enable,
> > disable and toggle camera access. These are useful, considering many
> > laptops today have key(s) for toggling access to camera.
> > 
> > This patch adds new key definitions for KEY_CAMERA_ACCESS_ENABLE,
> > KEY_CAMERA_ACCESS_DISABLE and KEY_CAMERA_ACCESS_TOGGLE. Additionally
> > hid-debug is adjusted to recognize this new usage codes as well.
> > 
> > Signed-off-by: Eray Orçunus <erayorcunus@gmail.com>
> > Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> I have rejected the drivers/platform/x86 patch which depends
> on this, because it changes current behavior, potentially
> breaking userspace.
> 
> Since this means I won't be taking any patches depending on
> this I believe it is best if this is merged through the input tree.
> 
> Note this also has a:
> 
> Acked-by: Jiri Kosina <jkosina@suse.cz>
> 
> tag given in this email thread.

OK, I picked it up.

Thanks.

-- 
Dmitry
