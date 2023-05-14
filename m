Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450D5701F85
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 22:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbjENUkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 16:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjENUkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 16:40:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3710E6D
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 13:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684096787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=chiG9B17KaDQNtNXqn0GHLZ1gAQxyO0beu2VdkhRIDA=;
        b=dqVrdnlkGLYGY5eRx/OsL905wFT+kLnYbKQPOXjYbeFXAXVGPL3Y2ueenNPINwswd761CV
        4DeB1wXCpPPyoa1CzeHlAc8MdVx8g4iTmXCN9vG8MNr4M3bUMx8WhYfK4ejfFd2tBpf2bi
        Xw6S/Z+HQWCSE/YBNujtVSPVX5NBE1w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-ZDrG9KcOPuuIr5mhcVfurA-1; Sun, 14 May 2023 16:39:43 -0400
X-MC-Unique: ZDrG9KcOPuuIr5mhcVfurA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3063a78f8a4so4249763f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 13:39:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684096781; x=1686688781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chiG9B17KaDQNtNXqn0GHLZ1gAQxyO0beu2VdkhRIDA=;
        b=cmU1SznpC7WKmauGjbiLW0d7nuLpXx4WXSzLNDGhq3KJ+iGANAg7RTigpBoteGbg7J
         AxH3g21qAqHwvEJ0NALYFsh1a7ZSz/ALGTwBmwscO+rZkEd/FSqh0LkdEBpO4+RnIMym
         FWmocT+t5Qf/wSoheYZkR2lHzsjn0bLERxCswcCilvXwkLlscaTMH2vM/dya4meLrUfW
         07Vo8JnmN95OUDhb2ZFsKaihLimGpx8CyWJhle/eSF5ThV/zjvulvSsec0+JHFs8c783
         GRScusQSGfoX6a9Hscv9RNe6GAgsr7+IH+TaaVEhrr6qbpLwCwcW2m3gAhBuFkW5afgw
         VmNQ==
X-Gm-Message-State: AC+VfDyL8mx22NWF9MRDPDdO2tXax+YTtZZsaOmJu+5gTfhvjQmdIIWn
        2rDn9ZRw2d8fHoo1D+ikkj4F0KgMK82hcQuOVkZS+fhzcRQXUuT1L95DkQ2YMQCVAC42dQEM2tC
        qbBmwCKSi6491JNbwLqNN+apIf0zHdizjIww=
X-Received: by 2002:adf:dd06:0:b0:306:368d:8a1c with SMTP id a6-20020adfdd06000000b00306368d8a1cmr21091452wrm.45.1684096781706;
        Sun, 14 May 2023 13:39:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5nN09h+Mnu8pLXs6TXZixhNLbNU43uh6S3TNFEVms1rYMbEDlOVaa7UVK4S4Nr+3W/+Sl3pg==
X-Received: by 2002:adf:dd06:0:b0:306:368d:8a1c with SMTP id a6-20020adfdd06000000b00306368d8a1cmr21091439wrm.45.1684096781330;
        Sun, 14 May 2023 13:39:41 -0700 (PDT)
Received: from redhat.com ([2.52.146.3])
        by smtp.gmail.com with ESMTPSA id g14-20020adff3ce000000b00300aee6c9cesm30425379wrp.20.2023.05.14.13.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 13:39:40 -0700 (PDT)
Date:   Sun, 14 May 2023 16:39:36 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     syzbot <syzbot+cbb68193bdb95af4340a@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, elic@nvidia.com, jasowang@redhat.com,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, parav@nvidia.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_setattr
Message-ID: <20230514163907-mutt-send-email-mst@kernel.org>
References: <000000000000a74de505f2349eb1@google.com>
 <000000000000a9377e05fbac4945@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000a9377e05fbac4945@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2023 at 12:24:32PM -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit a3c06ae158dd6fa8336157c31d9234689d068d02
> Author: Parav Pandit <parav@nvidia.com>
> Date:   Tue Jan 5 10:32:03 2021 +0000
> 
>     vdpa_sim_net: Add support for user supported devices
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16e372c6280000
> start commit:   e922ba281a8d Add linux-next specific files for 20230512
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=15e372c6280000
> console output: https://syzkaller.appspot.com/x/log.txt?x=11e372c6280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=17a4c2d44484b62f
> dashboard link: https://syzkaller.appspot.com/bug?extid=cbb68193bdb95af4340a
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172a21c6280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b67fc6280000
> 
> Reported-by: syzbot+cbb68193bdb95af4340a@syzkaller.appspotmail.com
> Fixes: a3c06ae158dd ("vdpa_sim_net: Add support for user supported devices")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

I don't see how this can be related, I don't think the test setup uses
vdpa sim at all.

-- 
MST

