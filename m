Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBC16A5101
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 03:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjB1CSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 21:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB1CSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 21:18:11 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6721186A4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 18:18:10 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id y14so3441512ilv.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 18:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g9TqYNjPNFKEn9o2CRG5ylaHlbZcxiO6CKaFD2QKerQ=;
        b=XUAsJofmvWzO6/rPEZJx3uXQo6Bb6sRVR0bnG7b2GkdGZxXYqdAZg1bSJusi6kqzQ6
         UdIzIn1v2i0YIo1X7U6MY6TrVqjU3MEoDZ97TUxf4zJRKSoy+168+2dFpulzwTBF6pxH
         d2ldQiRk1Qhzucovh2jc33+oVzgdtlyl13pBmnAWvgCoQpCKHAoBgfo/MH5memqMhhsQ
         6M47Ufq0HhQnzmr+yg2pCTLXYfApTVhOoXA+dS2896UVW1pIcjCGqkxppQDvVVWHHjX8
         DjGvm7L6/10Ek3W1X09C62e5+TXvrZLE63gVQVhhxeutunU936ujGuM3axIgzC/5OW1O
         v6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9TqYNjPNFKEn9o2CRG5ylaHlbZcxiO6CKaFD2QKerQ=;
        b=AHw8nrgjA4a1za72rzFe/pY5t1bf1TGhj1yvt1WQHXuAA1Ocuyq6fFOH5EybLbKVGB
         Bt4B8NyKDNVoO6jIBKSK98CZdsU0O0lx7JwlVmEl8F2t78mwlhDQ2ARzpfHQzxhEpRDI
         kobL2MnBbY5Ed9RaOl/7MnShcGCcoTxa6IYZOehBeijnXIMdT682y4LshOrbMz4g+ReR
         TMSUG1v51Mp2YDLTct9+xI6W6v5Zjgicd9dBdbUHNxkkaF2Ftm3GpwidDICn7aLyj9sz
         p1LxwFLvfckjJQXAhi8WP77YyqzpamG4eemDK3nmakWI2SEX/IL31vfU14Z7dyLW+kHG
         53iw==
X-Gm-Message-State: AO0yUKVC0keXvm5T7eJnB50EFJtPl5wnEmuzwMDTUq6OuDC4TmEN+iSb
        1NMQD+T+MVo+x9du7H7Kna8=
X-Google-Smtp-Source: AK7set9yeMt2xpmePzSBNnXyeVlTfqmfbnQzx9hYXmcCNB7p5gHw+e46PDaZ3soq+Ui2p7zPVyv7/w==
X-Received: by 2002:a05:6e02:1565:b0:316:b0bb:3d99 with SMTP id k5-20020a056e02156500b00316b0bb3d99mr1390656ilu.22.1677550689740;
        Mon, 27 Feb 2023 18:18:09 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l3-20020a02cce3000000b003e1fd49835asm2548087jaq.108.2023.02.27.18.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 18:18:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 27 Feb 2023 18:18:08 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Keith Busch <kbusch@meta.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, willy@infradead.org, hch@lst.de,
        tonyb@cybernetics.com, akpm@linux-foundation.org,
        kernel-team@meta.com
Subject: Re: [PATCHv4 11/12] dmapool: link blocks across pages
Message-ID: <20230228021808.GB3955901@roeck-us.net>
References: <20230126215125.4069751-1-kbusch@meta.com>
 <20230126215125.4069751-12-kbusch@meta.com>
 <20230227005445.GA3425881@roeck-us.net>
 <Y/1SfK4//04Tznvy@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/1SfK4//04Tznvy@kbusch-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 06:01:48PM -0700, Keith Busch wrote:
> On Sun, Feb 26, 2023 at 04:54:45PM -0800, Guenter Roeck wrote:
> > With this patch in linux-next, I see a boot failure when trying to boot
> > a powernv qemu emulation from the SCSI MEGASAS controller.
> > 
> > Qemu command line is
> > 
> > qemu-system-ppc64 -M powernv -cpu POWER9 -m 2G \
> > 	-kernel arch/powerpc/boot/zImage.epapr \
> > 	-snapshot \
> > 	-device megasas,id=scsi,bus=pcie.0 -device scsi-hd,bus=scsi.0,drive=d0 \
> > 	-drive file=rootfs-el.ext2,format=raw,if=none,id=d0 \
> > 	-device i82557a,netdev=net0,bus=pcie.1 -netdev user,id=net0 \
> > 	-nographic -vga none -monitor null -no-reboot \
> > 	--append "root=/dev/sda console=tty console=hvc0"
> > 
> > Reverting this patch together with "dmapool: create/destroy cleanup"
> > fixes the problem.
> 
> Thanks for the notice. I was able to recreate, and it does look like this is
> fixed with my more recent update changing the dma pool block order, and that is
> still pending out of tree. Would you also be able to verify? The patch is
> available here:
> 
>   https://lore.kernel.org/linux-mm/Y%2FzmUXrAiNujjoib@kbusch-mbp.dhcp.thefacebook.com/T/#t

Yes, that fixes the problem I have observed. I sent a Tested-by:
a minute ago.

Guenter
