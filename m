Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F91602105
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiJRCQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJRCQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:16:36 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D577A775
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:16:35 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so12648736pjl.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rfjsxbdlCkLSel7D8irY56QwwcFUqaYeuWBO7BuomM=;
        b=nWSNJOZAfMFtWxeBuAADGhbjDwVNaSbGuAEmJKCr9fVTPRlBIwmxOcCa8RbQhRtGPx
         HxYU5DR3wWHziBna8PzDKpBTP32PWZ+CRmBdQY4UY9lysUpOrzDLOtP+2TuQ1GHevFy/
         Q4FZGeNLaHFGSj0DDmYHJUGMtThVFMcYiJ0kJCRNxIWG/HopMdFM+JsShUYMr67NhEla
         Op6xu4L1t00asLfJWkyxuJ9cVZ15ti3lGPD2jZTn1axg8+B8fp2PvpjdZ9RTR305CTdh
         860mGpyXSoHiKKodnzakc2/0Y/NRc15jFX2XB8Xy59b0ToLxliEAO1nwaIEl7hOQ4KeS
         Qn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1rfjsxbdlCkLSel7D8irY56QwwcFUqaYeuWBO7BuomM=;
        b=F+FwTLfvD9JGPj6dNG8maiBCl5HGvNvuAfGeQFoL6m5dwl7fwJ6/G0yuvXFHtI36EO
         zLpQ7vtWaMkY6OzTD1yKfkqGnYTIHkKWhtd5gziSlGk8itGkN8RPanAB/QFdJboyGZ6u
         RvzR0i6oDWSTLZK4qELtJpPOM9OuF6um4b0p/hFNDo3Dil2qv3Ikf2OqueSDPx8ouCKP
         9xw8s02ziiCJCKFqCaoRPCGFusUes14puSNfk6spvG8U64A6DKrJAsKODc1DwJjxC+Uc
         J1gDGWMfTr9QXjX9364a9Ln+RB5PSaHki9rtS2BuXWWZg2+sllBZAFYVrWAQ6JJRplS4
         boaA==
X-Gm-Message-State: ACrzQf2iOySirpwUcV+91Ytel+ryrhWZIphwgzWucx0MR2iieKZ0U1qU
        ZrS7haXUmyWaDvPrQSDUKQo=
X-Google-Smtp-Source: AMsMyM5nJqPLybHRXBQRwFyOvHa6l93RAtgcoWn06O1/KWW8QftJQhCL4XtYXGjv4RB1aH6fSYuW/A==
X-Received: by 2002:a17:90a:86c6:b0:20b:dba4:758a with SMTP id y6-20020a17090a86c600b0020bdba4758amr901298pjv.71.1666059395218;
        Mon, 17 Oct 2022 19:16:35 -0700 (PDT)
Received: from localhost.localdomain ([111.203.234.211])
        by smtp.googlemail.com with ESMTPSA id 12-20020a17090a000c00b001fdcb792181sm6740435pja.43.2022.10.17.19.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:16:34 -0700 (PDT)
From:   Jintao Yin <nicememory@gmail.com>
To:     phillip@squashfs.org.uk
Cc:     bagasdotme@gmail.com, linux-kernel@vger.kernel.org,
        marcmiltenberger@gmail.com, mirsad.todorovac@alu.unizg.hr,
        regressions@leemhuis.info, regressions@lists.linux.dev,
        srw@sladewatkins.net
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with 6.0.0-rc3 through 6.0.0-rc7
Date:   Tue, 18 Oct 2022 10:15:06 +0800
Message-Id: <20221018021507.612-1-nicememory@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221015205936.5735-1-phillip@squashfs.org.uk>
References: <20221015205936.5735-1-phillip@squashfs.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 15, 2022 at 09:59:36PM +0100, Phillip Lougher wrote:
> Thorsten Leemhuis <regressions@leemhuis.info> wrote:
> >
> >Topposting, to make this easier to access for everyone.
> >
> >@Mirsad, thx for bisecting.
> >
> >@Phillip: if you want to see a problem description and the whole
> >backstory of the problem that apparently is caused by 	b09a7a036d20
> >("squashfs: support reading fragments in readahead call"), see this
> >thread (Mirsad sadly started a new one with the quoted mail below):
> >https://lore.kernel.org/all/b0c258c3-6dcf-aade-efc4-d62a8b3a1ce2@alu.unizg.hr/
> >
> 
> The above backstory tends to suggest data corruption which is happening
> after a couple of hours especially on heavy loads, e.g. the comment
> 
> > On 10/3/22 at 4:18 AM, Mirsad Goran Todorovac wrote:
> >The bug usually isn't showing immediately, but after a couple of hours 
> >of running (especially with multimedia running inside Firefox).
> 
> Which is typically caused by double freed buffers or race conditions in
> freeing and reusing.
> 
> Thanks Mirsad for the following
> 
> On Sat, 15 Oct 2022 16:59:44 +0200, Mirsad Goran Todorovac wrote:
> >
> >Here are the results of the requested bisect on the bug involving the 
> >Firefox snap build 104.x, 105.0.x, squashfs and which was manifested on 
> >both Ubuntu snap and with snapd in AlmaLinux 8.6 (CentOS fork):
> >
> >mtodorov@domac:~/linux/kernel/linux_stable$ git bisect log
> >git bisect start
> ># bad: [568035b01cfb107af8d2e4bd2fb9aea22cf5b868] Linux 6.0-rc1
> >git bisect bad 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
> ># good: [51dd976781da8c0b47e106ed59a96d7c28972ce4] Linux 5.19.15
> >git bisect good 51dd976781da8c0b47e106ed59a96d7c28972ce4
> ># good: [3d7cb6b04c3f3115719235cc6866b10326de34cd] Linux 5.19
> >git bisect good 3d7cb6b04c3f3115719235cc6866b10326de34cd
> ># good: [b44f2fd87919b5ae6e1756d4c7ba2cbba22238e1] Merge tag 
> >'drm-next-2022-08-03' of git://anongit.freedesktop.org/drm/drm
> >git bisect good b44f2fd87919b5ae6e1756d4c7ba2cbba22238e1
> ># good: [6614a3c3164a5df2b54abb0b3559f51041cf705b] Merge tag 
> >'mm-stable-2022-08-03' of 
> >git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> >git bisect good 6614a3c3164a5df2b54abb0b3559f51041cf705b
> ># bad: [eb5699ba31558bdb2cee6ebde3d0a68091e47dce] Merge tag 
> >'mm-nonmm-stable-2022-08-06-2' of 
> >git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> >git bisect bad eb5699ba31558bdb2cee6ebde3d0a68091e47dce
> ># good: [24df5428ef9d1ca1edd54eca7eb667110f2dfae3] ALSA: hda/realtek: 
> >Add quirk for HP Spectre x360 15-eb0xxx
> >git bisect good 24df5428ef9d1ca1edd54eca7eb667110f2dfae3
> ># good: [c993e07be023acdeec8e84e2e0743c52adb5fc94] Merge tag 
> >'dma-mapping-5.20-2022-08-06' of 
> >git://git.infradead.org/users/hch/dma-mapping
> >git bisect good c993e07be023acdeec8e84e2e0743c52adb5fc94
> ># good: [4cfa6ff24a9744ba484521c38bea613134fbfcb3] powerpc/64e: Fix 
> >kexec build error
> >git bisect good 4cfa6ff24a9744ba484521c38bea613134fbfcb3
> ># good: [24cb958695724ffb4488ef4f65892c0767bcd2f2] Merge tag 
> >'s390-5.20-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
> >git bisect good 24cb958695724ffb4488ef4f65892c0767bcd2f2
> ># good: [db98b43086275350294f5c6f797249b714d6316d] squashfs: always 
> >build "file direct" version of page actor
> >git bisect good db98b43086275350294f5c6f797249b714d6316d
> ># good: [6ba592fa014f21f35a8ee8da4ca7b95a018f13e8] video: fbdev: s3fb: 
> >Check the size of screen before memset_io()
> >git bisect good 6ba592fa014f21f35a8ee8da4ca7b95a018f13e8
> ># good: [b5a8466d37d30cfcc8015789f4a3f0c44b6c7bc6] Merge tag 
> >'for-5.20/fbdev-1' of 
> >git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev
> >git bisect good b5a8466d37d30cfcc8015789f4a3f0c44b6c7bc6
> ># bad: [97d3b2676fc6bc4865eb825037f4492f0fb804eb] ocfs2: remove some 
> >useless functions
> >git bisect bad 97d3b2676fc6bc4865eb825037f4492f0fb804eb
> ># bad: [591c32bddbe20ba0e172d9def3c7f22b9c926ad9] kernel/hung_task: fix 
> >address space of proc_dohung_task_timeout_secs
> >git bisect bad 591c32bddbe20ba0e172d9def3c7f22b9c926ad9
> ># bad: [b09a7a036d2035b14636cd4c4c69518d73770f65]  squashfs: support 
> >reading fragments in readahead call
> >git bisect bad b09a7a036d2035b14636cd4c4c69518d73770f65
> >mtodorov@domac:~/linux/kernel/linux_stable$
> >
> >The git bisect stopped at the squashfs commit 
> >b09a7a036d2035b14636cd4c4c69518d73770f65, so I included Phillip in Cc:, 
> >according to the Code of Conduct.
> 
> Which identified the "squashfs: support reading fragments in readahead call"
> patch.
> 
> There is a race-condition introduced in that patch, which involves cache
> releasing and reuse.
> 
> The following diff will fix that race-condition.  It would be great if
> someone could test and verify before sending it out as a patch.
> 
> Thanks
> 
> Phillip
Hi Phillip,
  There is a logical bug in commit 8fc78b6fe24c36b151ac98d7546591ed92083d4f
  which is parent commit of commit b09a7a036d2035b14636cd4c4c69518d73770f65.
  
  In function squashfs_readahead(...),
  file_end is initialized with i_size_read(inode) >> msblk->block_log,
  which means the last block index of the file.
  But later in the logic to check if the page is last one or not the
  code is 
    if (pages[nr_pages - 1]->index == file_end && bytes) {
      ...
    }
  , use file_end as the last page index of file but actually is the last
  block index, so for the common setup of page and block size, the first 
  comparison is true only when pages[nr_pages - 1]->index is 0.
  Otherwise, the trailing bytes of last page won't be zeroed.

  Maybe it's the real cause of the snap bug in some way.

  Thanks,

  Jintao  
> 
> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
> index e56510964b22..6cc23178e9ad 100644
> --- a/fs/squashfs/file.c
> +++ b/fs/squashfs/file.c
> @@ -506,8 +506,9 @@ static int squashfs_readahead_fragment(struct page **page,
>  		squashfs_i(inode)->fragment_size);
>  	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
>  	unsigned int n, mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
> +	int error = buffer->error;
>  
> -	if (buffer->error)
> +	if (error)
>  		goto out;
>  
>  	expected += squashfs_i(inode)->fragment_offset;
> @@ -529,7 +530,7 @@ static int squashfs_readahead_fragment(struct page **page,
>  
>  out:
>  	squashfs_cache_put(buffer);
> -	return buffer->error;
> +	return error;
>  }
>  
>  static void squashfs_readahead(struct readahead_control *ractl)
> 
