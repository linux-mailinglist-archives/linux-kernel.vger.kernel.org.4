Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E7E61FE30
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 20:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbiKGTIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 14:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiKGTIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 14:08:43 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687E8DEB7
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 11:08:42 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so11205172pji.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 11:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jTCNtbX3AF4Smxm3i3nu7Nj8Pslpw4wqg4w1w+kK/J4=;
        b=MNNfCg/5gVyQM81xzP8VzXC+EvdXULnq7Mb7cNh713opoViar0a21sBz/DLT3DvQ/U
         EtEG2ovwz3KOGJM0kQFDfuIqIEBm7HoJwq0EAvwaeq0vojP65qiR9VZgRnwUsMHx+Vv/
         zxWNVCjVJhFomMCXNwrMdUxXaOgIKqLqS/GQXI4MSblccq6+YW5BgB869PmeuotR2fN4
         GWLPB+6MVdEpl1xodsfoSdCf+WsM4uJP71wU1luMAf9DfgTaDU/b3m+DhcQUnr0+dx7o
         EOluKsh1E0USn4QwPfpVbvxSOT/9IPWcW43Trt8PHk9U7X9t6QucfZcHM+j7sxzne05x
         iF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTCNtbX3AF4Smxm3i3nu7Nj8Pslpw4wqg4w1w+kK/J4=;
        b=Kzq3xrft/DdsvplNVEz7ThlUcAlAKv4h6K3sx2fceu22//OcSUL8jTWw5VTAhWiIZg
         eshjSKgUelMdikFcIQngsR/dds3wQlUq78ndCqw8P6bkth2q3eOQjgGY3joDPiGaTuh0
         w/63TkOk5GBG4trDRpiL3NCrhveGjnzp3d8wCwbqfs3EuoYPqGuISiuDQdJUVyKype2W
         TTceSaGQGRpUlWoUT0/TmMeNCZxSugZ94GIPAsfvJAVLOddwifeyE2MCYg1N9NNE/5JL
         3MdHSNmjYa7D0K7vnhsDadHaCUkfAqZYdAivDOGjB2CUkJaVfQk4Ym2PCn63LaCTCk/8
         U6Dw==
X-Gm-Message-State: ACrzQf15crOVqXp7CJxBS5i/Ui8VIC7TXUUX5qkIvm93y/8owODow3ml
        mvQ2C8nUJH6N06GXxKBefxI=
X-Google-Smtp-Source: AMsMyM7qiZMp/mIjtcL9GXHPlUo3MWNaQnB96hUmeqVIY9GZGNQEd9h5lyDvqP9bRVn87eQe8m0LMg==
X-Received: by 2002:a17:90b:1c87:b0:20a:e485:4e21 with SMTP id oo7-20020a17090b1c8700b0020ae4854e21mr52941700pjb.194.1667848121820;
        Mon, 07 Nov 2022 11:08:41 -0800 (PST)
Received: from google.com ([2620:15c:211:201:594a:f636:e461:590b])
        by smtp.gmail.com with ESMTPSA id m12-20020a17090ab78c00b002132f3e71c6sm4572293pjr.52.2022.11.07.11.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 11:08:41 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 7 Nov 2022 11:08:39 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 2/9] zram: Add recompression algorithm sysfs knob
Message-ID: <Y2lXt9E6YqB7fRbQ@google.com>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
 <20221018045533.2396670-3-senozhatsky@chromium.org>
 <Y2LP0OWF/WTnkSne@google.com>
 <Y2Mv4l+V9iCv9EMg@google.com>
 <Y2Ptq1GZISCD7Mor@google.com>
 <Y2SEkzKSWx2iQzLl@google.com>
 <Y2Sat1/FCCT0Lia/@google.com>
 <Y2VPQlnEiP75mY5O@google.com>
 <Y2WjMQeS2DihvPQF@google.com>
 <Y2WnoVJ+Tn5kYWot@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2WnoVJ+Tn5kYWot@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2022 at 09:00:33AM +0900, Sergey Senozhatsky wrote:
> On (22/11/05 08:41), Sergey Senozhatsky wrote:
> > One can be SW one can be HW. So I thought about having flexibility here.
> > Instead of doing
> > 
> > 	for (idx = 1; idx < MAX_IDX; idx++) {
> > 		len = zcomp_compress(zram->comps[idx]);
> > 		if (len <= threshold)
> > 			break;
> > 	}
> > 
> > We would just directly use the suggested algo.
> > 
> > But we probably don't need that param at all and can use
> > the loop instead?
> 
> My idea was that recompress does not loop through the algos (what
> on the fly recompression can do for instance), but instead
> recompress only does one thing.
> 
> Because we can have, for instance, something like this
> 
> 	algo=zstd priority=1
> 	algo=deflate priority=2
> 
> And we recompress with algo=zstd only first. Without going
> into the slowest, most CPU and power consuming one. If the
> memory pressure keeps increasing then we might do algo=deflate
> recompress, as the last resort before we do writeback. But we
> may skip algo=deflate altogether and go straight to writeback,
> for instance because we have less than 30% of battery left.
> 
> So the reason I suggested algo= in recompress was, basically,
> for that for having exact control of what recompression does.


I am thinking like this:

* Without recomp_algo setup, user can do whatever they want on the fly


    echo "type=idle threshold=3000 algo=zstd" > recompress

Later they could do

    echo "type=idle threshold=3000 algo=deflate" > recompress

or
    
    writeback to backing device

* With recomp_algo setup like this,

    echo "algo=zstd priority=1" > recomp_algo
    echo "algo=deflate priority=2" > recomp_algo
    ..
    ..
    echo "type=idle threshold=3000" > recompress

If zstd fails, it will continue to work with deflate transparently.

IOW, "algo=" in *recompress* interface will override the global policy
in the *recomp_algo* setup. Otherwise, the recomp_algo's set up will
work.
