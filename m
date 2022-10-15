Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B5E5FFB35
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 18:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiJOQ36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 12:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiJOQ3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 12:29:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC88724BEA;
        Sat, 15 Oct 2022 09:29:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD5AAB80AC2;
        Sat, 15 Oct 2022 16:29:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48629C433C1;
        Sat, 15 Oct 2022 16:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665851388;
        bh=sQdcBFJbyLdmoMtfWOM1/83VBcRgDC2I8c7EfHwU+4Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JDNWNsl2LB67UtQisPuiZX9h8ygZLsAHV81gzLKhI+5lcC8aHoxruZYByrSggh7XF
         vSlIQ1bspTLNpSa8mGektdXwi80Q/jm7Pd4hfuzQyCMo8e+rYP5k1zoqu4qe8rgJde
         J+QBR6OI47xer1WoltqXYZbW2YCM/AzBRyXWLU5BmYZdJo5CbemEQ0WPa9E654meNZ
         twK3eGdwJP8vlvM5Ht6cxZZ/yXOE92EhIsCJ5PX1Tu5iGmwasxXhm4miu4wIMTKVmH
         kmCLLL/qcDIiNKmlGsJhe60YzIsLVDBHmR85XPU0DZPDchPSqaKvetD9fQ7eolEGqH
         X9wUlD0dAstZg==
Date:   Sat, 15 Oct 2022 17:30:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] =?UTF-8?B?wqd0b29sczo=?= iio: iio_generic_buffer: Fix
 read size
Message-ID: <20221015173014.0fb92829@jic23-huawei>
In-Reply-To: <Y0kMh0t5qUXJw3nQ@dc75zzyyyyyyyyyyyyycy-3.rev.dnainternet.fi>
References: <Y0kMh0t5qUXJw3nQ@dc75zzyyyyyyyyyyyyycy-3.rev.dnainternet.fi>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Oct 2022 10:15:19 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> When noevents is true and small buffer is used the allocated memory for
> holding the data may be smaller than the hard-coded 64 bytes. This can
> cause the iio_generic_buffer to crash.
> 
> Following was recorded on beagle bone black with v6.0 kernel and the
> digit fix patch:
> https://lore.kernel.org/all/Y0f+tKCz+ZAIoroQ@dc75zzyyyyyyyyyyyyycy-3.rev.dnainternet.fi/
> using valgrind;
> 
> ==339== Using Valgrind-3.18.1 and LibVEX; rerun with -h for copyright info
> ==339== Command: /iio_generic_buffer -n kx022-accel -T0 -e -l 10 -a -w 2000000
> ==339== Parent PID: 307
> ==339==
> ==339== Syscall param read(buf) points to unaddressable byte(s)
> ==339==    at 0x496BFA4: read (read.c:26)
> ==339==    by 0x11699: main (iio_generic_buffer.c:724)
> ==339==  Address 0x4ab3518 is 0 bytes after a block of size 160 alloc'd
> ==339==    at 0x4864B70: malloc (vg_replace_malloc.c:381)
> ==339==    by 0x115BB: main (iio_generic_buffer.c:677)
> 
> Fix this by always using the same size for reading as was used for
> data storage allocation.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 

Huh.  I have no idea why that value is 64...  And git blame says I wrote it
over 10 years ago :)

Patch looks fine to me, but given I don't understand the logic of the existing
code either I'll leave it on list for a little longer before picking it up.


> ---
> 
> This patch has been only tested with my kx022a sensor driver. Driver may
> have some culprits(s) and my understanding regarding IIO and these tools
> is limited so perhaps the hard-coded size of 64 bytes has perfectly
> legitimate reason - in which case I would appreciate to hear the
> reasoning so I could seek the problem from my driver. Also, I didn't add
> the fixes-tag as I don't really know which commit has caused the problem
> - as I am not 100% sure what the problem actually is and if I am just
> fixing a symptom here.
> ---
>  tools/iio/iio_generic_buffer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
> index 2491c54a5e4f..f8deae4e26a1 100644
> --- a/tools/iio/iio_generic_buffer.c
> +++ b/tools/iio/iio_generic_buffer.c
> @@ -715,12 +715,12 @@ int main(int argc, char **argv)
>  				continue;
>  			}
>  
> -			toread = buf_len;
>  		} else {
>  			usleep(timedelay);
> -			toread = 64;
>  		}
>  
> +		toread = buf_len;
> +
>  		read_size = read(buf_fd, data, toread * scan_size);
>  		if (read_size < 0) {
>  			if (errno == EAGAIN) {
> 
> base-commit: 4fe89d07dcc2804c8b562f6c7896a45643d34b2f

