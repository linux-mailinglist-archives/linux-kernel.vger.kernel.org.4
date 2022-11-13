Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED9F626E90
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 09:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbiKMIrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 03:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMIru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 03:47:50 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5D313D1E;
        Sun, 13 Nov 2022 00:47:49 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id v28so8464640pfi.12;
        Sun, 13 Nov 2022 00:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qjYVQm9t4CsKWNrFHUp422wO38f4GrtrUne+saETmR4=;
        b=WEZ6typR05P8XFZiqD10mGdrzsOxAtpq7h3P+FbGDRw+LZ5Zg6e13tstgwNpW8n5Cp
         QKv3lNQz3KkyjI2QQgDtoiuEL9QzeN7q+kTOHIMDSA6fdUqj/AjluN5scZ+mD1m5w6aM
         /1VbgNJN4e8rayZI47eZU2EuumVaactm3TfWiY0tNE3ikn1f7OWfABm9k8KJTnxdHytK
         6WJvQsLeqKOBwZR8QaagbRdjP1BPVEi9OzDeq8MzYJeKLi0e4ZnzQXdAOAD5WNmZfbt8
         KwCiunRU2MzmCQF2MEOFlHPEuFuCOR4H7fTJk6XDPvDSwD0EKyUagUApXu+wiuVv+jf6
         mAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjYVQm9t4CsKWNrFHUp422wO38f4GrtrUne+saETmR4=;
        b=HlJ3CoOSiBRBTvMl0NukxK1VfeCdGQgW4EDUw22dB3NfZDJ5WM8K8W7nwOWxPyABSK
         tM6aUvIeJBOdkRpHez0b+417DvJyVew8WU1u3/cenGydfrLRDynEfwQwYowrGz0Ta8yQ
         VMCVlYk2FKvzAWACbtEO/4nszefapsIlQBlINHTutiF0A2N2BnmC92ci3URM9VH7ZDLK
         fu48pgqAVMjIR0HK1ob8eDfiBWyoTeNfVX7aM2p7UZotcDBQaVdFeS6k+cGXxdeWolbp
         dKM7gBIdjNuIH5QZe835Kz01tTBQYF0uoLgWuaITOaEldwuX9WRxhg1zuAUxmKUgRAe8
         cZ+Q==
X-Gm-Message-State: ANoB5pkFQDqKpk9KNv7vS+pXNm2/6ie2k6rvNdTmPnClzKMawazCj+ts
        waLz0TTiCxmQbWu/RWbYgnji0H4NvJ0=
X-Google-Smtp-Source: AA0mqf5hLEoxPLonCQIpqAScsjvmsD08Dtlo3ffPnm9vsrcMmOwXCT1s9PgJ7TrJ/HwPZ3ZhIMiN/w==
X-Received: by 2002:a63:e617:0:b0:46f:f4e3:c4b1 with SMTP id g23-20020a63e617000000b0046ff4e3c4b1mr7605381pgh.588.1668329269205;
        Sun, 13 Nov 2022 00:47:49 -0800 (PST)
Received: from ubuntu ([211.193.26.134])
        by smtp.gmail.com with ESMTPSA id p129-20020a622987000000b0056bbebbcafbsm4354978pfp.100.2022.11.13.00.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 00:47:48 -0800 (PST)
Date:   Sun, 13 Nov 2022 00:47:40 -0800
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     Eli Billauer <eli.billauer@gmail.com>
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, imv4bel@gmail.com
Subject: Re: [PATCH v2] char: xillybus: Prevent use-after-free due to race
 condition
Message-ID: <20221113084740.GA6458@ubuntu>
References: <20221030094209.65916-1-eli.billauer@gmail.com>
 <20221113080558.GA5854@ubuntu>
 <2a8f59ac-9d49-ffa3-b035-809f2fac38ec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a8f59ac-9d49-ffa3-b035-809f2fac38ec@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear,

On Sun, Nov 13, 2022 at 10:30:16AM +0200, Eli Billauer wrote:
> On 13/11/2022 10:05, Hyunwoo Kim wrote:
> > Dear,
> > 
> > Sorry for the late review.
> > 
> > This patch cannot prevent the UAF scenario I presented:
> > ```
> >                  cpu0                                                cpu1
> >         1. xillyusb_open()
> >            mutex_lock(&kref_mutex);    // unaffected lock
> >            xillybus_find_inode()
> >            mutex_lock(&unit_mutex);
> >            unit = iter;
> >            mutex_unlock(&unit_mutex);
> >                                                               2. xillyusb_disconnect()
> >                                                                  xillybus_cleanup_chrdev()
> >                                                                  mutex_lock(&unit_mutex);
> >                                                                  kfree(unit);
> >                                                                  mutex_unlock(&unit_mutex);
> >         3. *private_data = unit->private_data;   // UAF
> > 
> > ```
> > 
> > This is a UAF for 'unit', not a UAF for 'xdev'.
> > So, the added 'kref_mutex' has no effect.
> > 
> 
> You're correct. This submitted patch solves only one problem out of two. It
> prevents the content of @private_data to be freed, but you're right that
> @unit itself isn't protected well enough.
> 
> The problem you're pointing at is that @unit can be freed before its
> attempted use, because the mutex is released too early.
> 
> This is easily solved by moving down the mutex_unlock() call to after @unit
> has been used. Do you want the pleasure to submit this patch, or should I?

I hope you work as before.

And, even if the mutex_unlock(&unit_mutex); of xillybus_find_inode() 
is finally moved, xdev may be released before kref_get() is executed 
if xillyusb_disconnect() ends just before the function returns. 
(Of course, this is an extremely rare case.)

So, in xillyusb_open() we need to move kref_get() above xillybus_find_inode().


Regards,
Hyunwoo Kim
