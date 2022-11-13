Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C49626EAE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 10:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbiKMJOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 04:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234204AbiKMJOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 04:14:22 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92575FE3;
        Sun, 13 Nov 2022 01:14:21 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id g24so7642828plq.3;
        Sun, 13 Nov 2022 01:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jm8CPr0nbrT5CX5c1JBR2j22AkvfIMg2xW2ALzqRYHc=;
        b=qoegYSEzF6W2EQAKMzO+HkowdDxrQ7A5mQu0KWbhd8a96SHhc/mnIKxuBM0tLq54uu
         6zxavP+qNWOIlOaq/81HD9NuqKZxKyy2HWQAzR+q2lJgSIHL/7nRJBOEUuztLXRlzbIw
         62v7uh46Q4bbW3Xc2wwq6tUqdLoUFgFqO7CXTifbKIQRTcDDVJlhnwNU6h+9KlzKD2vZ
         W8ngAeB6FwhlIAlfr3nO4PJJ9f/50kYbEj5tknlSG9O8CQ4Xo6Z1EhZORjF/WunrMwSr
         XQ9aRFg7KqwLY7RnWl9ss1kmn+nqP0G5gM711CTjwepIRgkj0FXiGjVN3Ksn0z09Klbz
         8t5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jm8CPr0nbrT5CX5c1JBR2j22AkvfIMg2xW2ALzqRYHc=;
        b=yNvBweSkDKuWZkT8ilrjD9d5DyVG9MIArezS2jOn2hP19W2ttIZ0UxNmS+nvELzj0Q
         MAuPEUEcrM/8qMmDbbXxQ5NROKCKqU3cpAd0g60AWLhQ4CazVJsuTZctGFfkUxXt5VQ4
         JOZ9AK5ZSK5JYzeLbyCdHgVTMasv0dz0mjwCzrVXz+bjwyDJl4eF/wpNRd4zDWQhhFfo
         lYoNeEinwSGz8LwN14xdsnO8ktFlsqv9fimpI2e4b1rqip82HyAU58VSE6Yvbzg/AqCQ
         Gx5hXdD9yWC7NLGfAv5y34xHe48yrBp+KWpAlpTFSw97lTLTLGgsAD0mm2gjNnoFo98n
         28JA==
X-Gm-Message-State: ANoB5plHRc2O4y/QvOu73KJNufSTPAIYnTwrTXsFTeogGTdmAk7I6On/
        bHowuRu+ISaELkfW4VLxDig=
X-Google-Smtp-Source: AA0mqf5wTaSV0glZxJYamyH1IuEgvK0gXd3ogOGGQfj4a1xJ9Ptbf1VrNeBan/X57KSsNfoWJcQMXA==
X-Received: by 2002:a17:902:bc83:b0:186:8af2:8bc8 with SMTP id bb3-20020a170902bc8300b001868af28bc8mr9322491plb.146.1668330860802;
        Sun, 13 Nov 2022 01:14:20 -0800 (PST)
Received: from ubuntu ([211.193.26.134])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902a50700b00182d25a1e4bsm4772280plq.259.2022.11.13.01.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 01:14:20 -0800 (PST)
Date:   Sun, 13 Nov 2022 01:14:15 -0800
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     Eli Billauer <eli.billauer@gmail.com>
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, imv4bel@gmail.com
Subject: Re: [PATCH v2] char: xillybus: Prevent use-after-free due to race
 condition
Message-ID: <20221113091415.GA8314@ubuntu>
References: <20221030094209.65916-1-eli.billauer@gmail.com>
 <20221113080558.GA5854@ubuntu>
 <2a8f59ac-9d49-ffa3-b035-809f2fac38ec@gmail.com>
 <20221113084740.GA6458@ubuntu>
 <c9a03f08-8117-cd24-b4e3-9e097e3069f2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9a03f08-8117-cd24-b4e3-9e097e3069f2@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2022 at 11:03:20AM +0200, Eli Billauer wrote:
> On 13/11/2022 10:47, Hyunwoo Kim wrote:
> > And, even if the mutex_unlock(&unit_mutex); of xillybus_find_inode()
> > is finally moved, xdev may be released before kref_get() is executed
> > if xillyusb_disconnect() ends just before the function returns.
> > (Of course, this is an extremely rare case.)
> > 
> > So, in xillyusb_open() we need to move kref_get() above xillybus_find_inode().
> 
> First of all, that's impossible. kref_get() is called on a member of a
> specific @xdev's struct, and it's xillybus_find_inode()'s job to find it. So
> before the call to xillybus_find_inode(), we don't know which @xdev it is.
> That's the tricky part of all this.
> 
> The solution of this submitted patch was a lock that briefly prevents the
> kref_put() of all @xdevs. The way it works is that if an @xdev is found by
> xillybus_find_inode(), it necessarily means that xillyusb_disconnect()'s
> call to xillybus_cleanup_chrdev() hasn't returned (yet). Therefore, holding
> @kref_mutex guarantees that the kref_put() call, which is later on, isn't
> reached for the @xdev that has been found.
> 
> If you've found a flaw in this mechanism, please be more specific about it.

you're right.

It seems that you only need to move the location of unit_mutex 
in xillybus_find_inode().


Regards,
Hyunwoo Kim
