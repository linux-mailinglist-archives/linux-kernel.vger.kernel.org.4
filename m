Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B8E6DC2B1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 04:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjDJCYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 22:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjDJCYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 22:24:45 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80BC40D7;
        Sun,  9 Apr 2023 19:24:28 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id j8so1344827pjy.4;
        Sun, 09 Apr 2023 19:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681093468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A1UI2o30pT9Hi/87peHLOtQusZd6rghspWdn2S7xv4s=;
        b=c94fsjL6JJVY9BPRGg+uSAZ0BULulqhni26xSiQaa/SCtElVEukB+kARgM3QkQfyXd
         Eh5p3S3ag7ti+aUf/5HnD3S9lHPoU/NKOUYWutwfNKriPWV9mmwOxoPZTAwS5+H5zBfu
         bRgoEnwzzYbNCQTwApbM5IeEnNUqkLYCxUseumNiPKAeSYgKorZTbNe0K4gNXlb89mwv
         JgVrh8MvU0BmTXg6M2LdLhl156km5LNFNkfYT02bQ6+FCoTtGwkwS0NsvHZnqhRbt24P
         /xC5/nLcecK2l9efdAGT9Tm0cyBd8uzMkfhu0+ZZee0fjF0V54qxe0ku2Yt3OBcw7Kt9
         FF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681093468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1UI2o30pT9Hi/87peHLOtQusZd6rghspWdn2S7xv4s=;
        b=gxOFayEYf1G5ZbShyK3rmtwFIWTIQ80siz3Zf2okRsZFJIEU9PlhGWOy97nn8WmHTz
         g5sP5E+yASmVjQ2vfHRub66EEA3FBN1NGnOQb36I52SaEHMt2OguQjQkUj4ZZM7fqAyQ
         /VY8oFoqXZBStKW+XajKwRTSjkvXjDXGAjCPfGdkKN/aI6g23DZ9Hg3r0ccnhic7h6yw
         EUU10vxOk+BUt7s2WAMbq63TV+h2c1Cn6ZaYiqmCidX3pg2kUYWxjJ0nuK4Z7rrsP1P4
         WrWPdnjpG+o2oP0hnctZJ3K4AzNPIqpL6sBsAhqV971VYYA8TzkUf/zR1aj4iBhwEZCb
         leYQ==
X-Gm-Message-State: AAQBX9fcezNYNrtvM3qdI2nJx0vVjE7Erf0EoQNfs/ah6ZZ7Lbg+xxHo
        wbxzsbAWlS2oypCRCWAYXoc=
X-Google-Smtp-Source: AKy350aDs4UZ/tV+VjOOGiqFLzeH/HVg7N4qx7sm0xNcxpT5geXq/9Lx/JfLN3YTjaybGFlcW7HJqQ==
X-Received: by 2002:a05:6a20:b326:b0:d6:c9e2:17a1 with SMTP id ef38-20020a056a20b32600b000d6c9e217a1mr8343706pzb.62.1681093467624;
        Sun, 09 Apr 2023 19:24:27 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:803c:4683:913e:ce04])
        by smtp.gmail.com with ESMTPSA id j3-20020aa79283000000b005d22639b577sm6611680pfa.165.2023.04.09.19.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Apr 2023 19:24:27 -0700 (PDT)
Date:   Sun, 9 Apr 2023 19:24:24 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Soumya Negi <soumya.negi97@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: Check sanity of pipe in pegasus_probe()
Message-ID: <ZDNzWH69OCefPW+G@google.com>
References: <20230404074145.11523-1-soumya.negi97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404074145.11523-1-soumya.negi97@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 12:41:45AM -0700, Soumya Negi wrote:
> Fix WARNING in pegasus_open/usb_submit_urb
> Syzbot bug: https://syzkaller.appspot.com/bug?id=bbc107584dcf3262253ce93183e51f3612aaeb13
> 
> Warning raised because pegasus_driver submits transfer request for
> bogus URB(pipe type does not match endpoint type). Add sanity check at
> probe time for pipe value extracted from endpoint descriptor. Probe
> will fail if sanity check fails.
> 
> Reported-and-tested-by: syzbot+04ee0cb4caccaed12d78@syzkaller.appspotmail.com
> Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>

Applied, thank you.

-- 
Dmitry
