Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E667F5E8E7E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 18:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiIXQdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 12:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiIXQdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 12:33:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D9E67440;
        Sat, 24 Sep 2022 09:33:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C189B80687;
        Sat, 24 Sep 2022 16:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72F3C433C1;
        Sat, 24 Sep 2022 16:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664037179;
        bh=eDvZ24I+VwB0DHpkH5Ck7T+J+ic8MD34cgwf6xb0jRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uQeJTf1RYI/ZbQfhH2m/NC/v1SafpCBdOJK8fW7ydFR8PcZLhGsv8P62B4RY2Duh/
         mpJiYkCbirm5JDz8zNoU4/Z+YrA5TOTMYIwoJ0LeK3z8PH7Lfbqc3yjlLv6i0FQZ9e
         5W15s61HmqFG4oRQjRC5uSZIBGn3/fJzXi3Wb/dzBix/m7OvwqFJXUVKo2hKl3re01
         tAyjPZv8x54fiZ85Ui6LN31IXsvCk0zPo9vhGoDbSvTS7HjxGji/vWSTbe8cMaovLl
         H/NMC0wEgCyvmQCbx5G7UvUCu8+nFyNgIGMuG3OVLCHHcd8eBxksUxdNIPBFnmsWpW
         f/TN+1cPkApEQ==
Date:   Sat, 24 Sep 2022 11:32:54 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
        syzbot+9d14351a171d0d1c7955@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ovl: Use "buf" flexible array for memcpy() destination
Message-ID: <Yy8xNjsZ1N/wbV8s@work>
References: <20220924073315.3593031-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924073315.3593031-1-keescook@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 12:33:15AM -0700, Kees Cook wrote:
> The "buf" flexible array needs to be the memcpy() destination to avoid
> false positive run-time warning from the recent FORTIFY_SOURCE
> hardening:
> 
>   memcpy: detected field-spanning write (size 93) of single field "&fh->fb" at fs/overlayfs/export.c:799 (size 21)
> 
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: linux-unionfs@vger.kernel.org
> Reported-by: syzbot+9d14351a171d0d1c7955@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/all/000000000000763a6c05e95a5985@google.com/
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>  fs/overlayfs/export.c    | 2 +-
>  fs/overlayfs/overlayfs.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> index e065a5b9a442..ac9c3ad04016 100644
> --- a/fs/overlayfs/export.c
> +++ b/fs/overlayfs/export.c
> @@ -796,7 +796,7 @@ static struct ovl_fh *ovl_fid_to_fh(struct fid *fid, int buflen, int fh_type)
>  		return ERR_PTR(-ENOMEM);
>  
>  	/* Copy unaligned inner fh into aligned buffer */
> -	memcpy(&fh->fb, fid, buflen - OVL_FH_WIRE_OFFSET);
> +	memcpy(fh->buf, fid, buflen - OVL_FH_WIRE_OFFSET);
>  	return fh;
>  }
>  
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 87759165d32b..a0e450313ea4 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -108,7 +108,7 @@ struct ovl_fh {
>  	u8 padding[3];	/* make sure fb.fid is 32bit aligned */
>  	union {
>  		struct ovl_fb fb;
> -		u8 buf[0];
> +		DECLARE_FLEX_ARRAY(u8, buf);
>  	};
>  } __packed;
>  
> -- 
> 2.34.1
> 
