Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2916721109
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 17:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjFCPzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 11:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjFCPzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 11:55:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACCFB3;
        Sat,  3 Jun 2023 08:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=R5zYDzwo/pDHUr0DCv4Xr6Wm2HvTFwwN/7z8R7irekc=; b=uS9Hj2auVoA4GO+poXznQY4qIA
        JYoJKOsrZuIClN/+8r/oi7GeMeT/RzQDV2mzkvx0gqHouz5Qw3OH7kkurPyWRvX1ziuh/E/4F5PWJ
        LzH23jsv8Xe+7VHqBZfBeWUTWxSxwnzqA9PHfZBM3AGTzAkh32pwmvg2kbCeVhnS86JJOpeb+IyfF
        b5OMRyQXW03joPKKiJfAeN4Xl8GWiDkDWomZppnJkM1p+1qNoUDhaEaurWyTuB1EGRR9dxMpM0/zW
        VYKyq4DcpQROpfR9O+xMaevhxXMwkmmA/ffkhk2V26ruvgig0MpYRe6gEYIUDQP2B3BD2jSzMKRJd
        c2YCuzeA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q5TbS-00A5nv-15;
        Sat, 03 Jun 2023 15:55:42 +0000
Message-ID: <975d35cb-e0aa-8ea7-5520-238d1aa4cbaf@infradead.org>
Date:   Sat, 3 Jun 2023 08:55:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC] docs: process: Send patches 'To' maintainers and 'Cc' lists
Content-Language: en-US
To:     James Seo <james@equiv.tech>, Jonathan Corbet <corbet@lwn.net>
Cc:     Kalle Valo <kvalo@kernel.org>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230603151447.29288-1-james@equiv.tech>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230603151447.29288-1-james@equiv.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 6/3/23 08:14, James Seo wrote:
> The existing wording in the 'Select the recipients for your patch'
> section of submitting-patches.rst states that contributors should
> 'copy' maintainers and lists, which might be interpreted to mean that
> patch e-mails should be sent 'Cc' such recipients without any 'To'
> recipients at all.
> 
> Indeed, this does happen on occasion (and to be fair, examples of the
> practice predating the submitting-patches document exist in kernel
> mailing list archives). It isn't a problem on the protocol level, as
> SMTP itself deals only with SMTP commands (cf. 'RCPT TO'), but
> software that works with MIME headers in message text, perhaps in
> order to generate those commands, doesn't always handle the situation
> well.
> 
> At present, when such an e-mail is sent to the vger listservs, the
> MIME header 'To: unlisted-recipients:; (no To-header on input)' is
> added to it somewhere along the chain. 'unlisted-recipients:;' is a
> valid RFC 5322 Group Address, but it (or '(no To-header on input)')
> sometimes goes on to cause problems itself further down the line.
> 
> For example, in mutt, it can result in the silent removal of all 'Cc'
> recipients (e.g. kernel mailing lists) from a group reply, leaving
> the 'To' recipient that the original e-mail was 'From' as the only
> actual reply recipient [1]. Other issues [2] are possible in other
> software [3]. It also bears mentioning that a lack of 'To' headers is
> a characteristic of some spam, so such an e-mail may trigger some
> spam filters.

It sounds to me like we should just prohibit (not allow) emails that
don't have a To: recipient in them. It also sounds like mutt (and maybe
other software) have problems.

Is that something that vger could do?  (although we have other
email servers as well, e.g., infradead).

> To reduce ambiguity and eliminate this class of potential (albeit
> tangential) issues, prescribe sending patches 'To' maintainers and
> 'Cc' lists. While we're at it, strengthen the recommendation to use
> scripts/get_maintainer.pl to find patch recipients, and move Andrew
> Morton's callout as the maintainer of last resort to the next
> paragraph for better flow.
> 

I think that is going overboard (too far). As long as a maintainer
is a direct recipient of the email (patch), that should be sufficient.

> Link: https://github.com/neomutt/neomutt/issues/2548 [1]
> Link: https://github.com/python/cpython/issues/83281 [2]
> Link: https://github.com/kvalo/pwcli/issues/15 [3]
> Signed-off-by: James Seo <james@equiv.tech>
> ---
>  Documentation/process/submitting-patches.rst | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index efac910e2659..53460f3cdc1d 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -231,14 +231,15 @@ patch.
>  Select the recipients for your patch
>  ------------------------------------
>  
> -You should always copy the appropriate subsystem maintainer(s) and list(s) on
> -any patch to code that they maintain; look through the MAINTAINERS file and the
> -source code revision history to see who those maintainers are.  The script
> -scripts/get_maintainer.pl can be very useful at this step (pass paths to your
> -patches as arguments to scripts/get_maintainer.pl).  If you cannot find a
> -maintainer for the subsystem you are working on, Andrew Morton
> -(akpm@linux-foundation.org) serves as a maintainer of last resort.
> -
> +You should always notify the appropriate subsystem maintainer(s) and list(s)
> +about any patch to code that they maintain.  Identify them by looking through
> +the MAINTAINERS file and the source code revision history, and by using the
> +script scripts/get_maintainer.pl (pass paths to your patches as arguments to
> +scripts/get_maintainer.pl).  Send your patch e-mail "To:" those maintainers and
> +"Cc:" those lists.
> +
> +If you cannot find a maintainer for the subsystem you are working on, Andrew
> +Morton (akpm@linux-foundation.org) serves as a maintainer of last resort.  Also,
>  linux-kernel@vger.kernel.org should be used by default for all patches, but the
>  volume on that list has caused a number of developers to tune it out.  Please
>  do not spam unrelated lists and unrelated people, though.

-- 
~Randy
