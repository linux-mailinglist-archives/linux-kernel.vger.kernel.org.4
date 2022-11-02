Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BBC615B9B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 05:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiKBE5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 00:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKBE5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 00:57:01 -0400
Received: from hermod.demsh.org (hermod.demsh.org [45.140.147.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D14112754;
        Tue,  1 Nov 2022 21:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=demsh.org; s=022020;
        t=1667365015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wfWIIDD9CBtF28Mqs8I/NJkhL1FFYUKOzBxv2/nTM/Q=;
        b=jnJf2zB95abymLK0B8TgMZVBkbH8B7Sj8CwWHLbhZ+lmWbqM6o06tpQKP1JoDiMjKOasT7
        CXrjEG4ODtqaIN4Vhszj0w/XXFmFthd7NJqEI9mpyvHbQRRNms/rCAfAAKAixc7k4P4f8e
        6Dd2V+/lR15y6BjwGNba+oNhsdtEBQM8z7RTg7PyJtJVtjbgvkERqqnDKlAYdzhjLvkyaQ
        BH73MzoQCLXeFoFDSDZLz2H5FNsMJPCHpHj5WeMPUYf9VDDmCEPrZTcVjrtRYYdFHK+/JJ
        tKCUfiAhtn4Nr9nKSP7CAoIZU309HFXmLHGQyLyY+h6lZl161hWlqp5bJKNxUw==
Received: from xps.demsh.org (algiz.demsh.org [94.103.82.47])
        by hermod.demsh.org (OpenSMTPD) with ESMTPSA id d6ea86f8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO) auth=yes user=me;
        Wed, 2 Nov 2022 04:56:55 +0000 (UTC)
Date:   Wed, 2 Nov 2022 07:57:03 +0300
From:   Dmitrii Tcvetkov <me@demsh.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [bisected] RAID1 direct IO redirecting sector loop since 6.0
Message-ID: <20221102075703.63ec7876@xps.demsh.org>
In-Reply-To: <20221102010826.12dcb4bb@xps.demsh.org>
References: <20221101001558.648ee024@xps.demsh.org>
        <Y2FVzdcro8HCfODK@kbusch-mbp>
        <20221101235144.06a3dbd3@xps.demsh.org>
        <Y2GNHEtDnoybz+fW@kbusch-mbp>
        <20221102010826.12dcb4bb@xps.demsh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2022 01:08:26 +0300
Dmitrii Tcvetkov <me@demsh.org> wrote:

> On Tue, 1 Nov 2022 15:18:20 -0600
> Keith Busch <kbusch@kernel.org> wrote:
> > Oh shoot, sorry about that! Should have been this:
> > 
> > @@ -703,6 +702,7 @@ void disk_stack_limits(struct gendisk *disk,
> > struct block_device *bdev, pr_notice("%s: Warning: Device %pg is
> > misaligned\n", disk->disk_name, bdev);
> > 
> > +       blk_queue_dma_alignment(t, queue_logical_block_size(t) - 1);
> >         disk_update_readahead(disk);
> >  }
> >  EXPORT_SYMBOL(disk_stack_limits);
> 
> This didn't change behaviour, second guest still hangs.

Managed to write a program in C, which allows to reproduce this without
Qemu.

# cat test.c
#define _GNU_SOURCE

#include <stdlib.h>
#include <unistd.h>                    
#include <stdio.h>    
#include <fcntl.h>    
#include <string.h>   
#include <errno.h>    
#include <pthread.h>  
                                               
#define THREADCOUNT 8 
#define PATHLIMIT 256 
#define BUFSIZE 4096
                                               
#define LV1 "/dev/lvmraid/zfs"
#define LV2 "/dev/lvmraid/wrk"           
                                                                                               
struct params {  
  char path[PATHLIMIT];
  char buffer[BUFSIZE];
};   
                                               
                                               
struct params alloc_params(char *path) {     
  struct params out;
                                                                                               
  if (strlen(path) >= PATHLIMIT) {
    printf("supplied path too long\n");
    abort();
  }
                                               
  strncpy(&out.path[0], path, PATHLIMIT);
  memset(&out.buffer, 0, BUFSIZE);
  return out;
}

void *worker(void *data) {
  struct params *p = (struct params *) data;
  int counter = 0;
  ssize_t n = 0;
   
  int fd = open(p->path, O_RDONLY|O_DIRECT|O_CLOEXEC);
  if (fd == -1) return NULL;
   
  while (counter < 2048) {
    pread(fd, p->buffer, BUFSIZE, 0);
    counter++;
  }

  close(fd);
  return NULL;
}

int main(void) {
  struct params parray[THREADCOUNT] = {
    alloc_params(LV1),
    alloc_params(LV1),
    alloc_params(LV1),
    alloc_params(LV1),
    alloc_params(LV2),
    alloc_params(LV2),
    alloc_params(LV2),
    alloc_params(LV2),
  };
  pthread_t threads[THREADCOUNT];

  for (int i = 0; i < THREADCOUNT; i++) {
    int ret = pthread_create(&threads[i], NULL, worker, (void *)
  &parray[i]); if (ret!=0) {
      printf("failed to create thread: %d", ret);
      abort();
    }
  }
  for (int i = 0; i < THREADCOUNT; i++) {
    int ret = pthread_join(threads[i], NULL);
    if(ret!=0) {
      printf("failed to join thread: %d", ret); 
      abort();
    }
  }
   
  return 0;
}

# gcc -O2 -pthread test.c
# for i in $(seq 1 64); do ./a.out;done
