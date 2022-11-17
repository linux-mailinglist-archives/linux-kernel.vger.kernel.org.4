Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0A362E747
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240511AbiKQVsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240338AbiKQVsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:48:17 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2FE69DD8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:48:17 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id q1so3256832pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/HyEb+JRj1sN5jcDVViOGE116tvvuVTKsQc2QDnF6Sk=;
        b=JrPNa/9vanKmhuJZy8rXzQjTS61AAtv3k9qysjVd2Yzu49dZaR9D++0L/kmHEL29MB
         PHni9yqVUqm7PXe/RRllu1ll5XoZhgUrc1sTqkiPYEVWSPFY17gp6J0v5YBPG3jDiITa
         4JYrIIlCK85DhzjIoBvB9KvJpRw4ZpZElS9b8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HyEb+JRj1sN5jcDVViOGE116tvvuVTKsQc2QDnF6Sk=;
        b=2awFedfVUqCJcNkOAkQ5CrWOoHWYe1Qd76Eh2ZU3pxXdWqnyqdfPt5VLWT5BNmQUDo
         nZdEU284IXx0qxz1zimfRCmrj/kHuTg0QEBBKtF2UDtfVKrX2U6/YlHXUVHLyHKbU8o3
         Rfv8stzj50DsXt6AwTpo+h/TKuflhqXKRnUdcHQCXCYxZ9hiuvkMuROoWKOlUHuLfpwv
         nk54bLlLLy5q9EVwu4qVehTtUikWHTdpAtg9/rOZxMMYhGu2B0/khd/vGHwZ7puF9Qvw
         0hUHjg6yKP0XEKXPiAAwQsoJU3CZlJxR0dSyvuL7zkDAlj9iOfigVbk4a5ivwi+YFmz0
         CPJQ==
X-Gm-Message-State: ANoB5pkJw/1pxMSUcPoHCUUINKB8aM3H8usniHj/PGm/uvZ1nm5NtEZh
        KZ/TTxuZtPHlzWWoFVRcx0YpYQ==
X-Google-Smtp-Source: AA0mqf6E1Rlp5WSdo0sVrZK6tL4GimR07/xtQ5dLpX8vEo9oCMCQw+NxaqGW5aW6REqbGjiH5xxmCQ==
X-Received: by 2002:a63:f003:0:b0:45f:bf86:c917 with SMTP id k3-20020a63f003000000b0045fbf86c917mr3884645pgh.201.1668721696522;
        Thu, 17 Nov 2022 13:48:16 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s125-20020a632c83000000b00439d071c110sm1525368pgs.43.2022.11.17.13.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 13:48:15 -0800 (PST)
Date:   Thu, 17 Nov 2022 13:48:14 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, tytso@mit.edu, kees@kernel.org,
        linux@armlinux.org.uk, ydroneaud@opteya.com,
        gregkh@linuxfoundation.org, rdunlap@infradead.org
Subject: Re: [PATCH v3] random: add helpers for random numbers with given
 floor or range
Message-ID: <202211171347.92FDE65A6D@keescook>
References: <2b3bc31e-c308-b04c-1759-26bcf8dba6d3@infradead.org>
 <20221117192620.2304613-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117192620.2304613-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 08:26:20PM +0100, Jason A. Donenfeld wrote:
> Now that we have get_random_u32_below(), it's nearly trivial to make
> inline helpers to compute get_random_u32_above() and
> get_random_u32_inclusive(), which will help clean up open coded loops
> and manual computations throughout the tree.
> 
> One snag is that in order to make get_random_u32_inclusive() operate on
> closed intervals, we have to do some (unlikely) special case handling if
> get_random_u32_interval(0, U32_MAX) is called. The least expensive way
> of doing this is actually to adjust the slowpath of
> get_random_u32_below() to have its undefined 0 result just return the
> output of get_random_u32(). We can make this basically free by calling
> get_random_u32() before the branch, so that the branch latency gets
> interleaved.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

I really like these -- unambiguous! :) Thanks for adjusting this API.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
