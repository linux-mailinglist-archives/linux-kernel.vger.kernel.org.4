Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40315BA7D6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 10:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiIPILc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 04:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiIPILa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 04:11:30 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758744F675
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 01:11:29 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id c24so19647147pgg.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 01:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=HAXwkx/uYexRSiAooA8OWBY5Zfggqz9KkW8MSeKRhAY=;
        b=LgoHcR422J6Q1Fa4t3wbWbINjlk1+7//FJ8ydCb6FHgcS//+MLNGBgFMQw6hME1VyK
         EDu+pUfvqGbH78wfaQC8NGh5JxGTecaUd5eqdEUazwaQZkz5SEV5oWtm5NKkEgWExboe
         tvPlqRN4RRX6copZ9lcEwJnhVUZ8ou4RXY33Ax0TZEQe8Ab3/qmcmoIr5egNE3tJ8TMK
         P3s0gYq1qRLGQ59ixIQwNlLJXq6Y+WP+5UlPhJhFk0vPRCF/X0QfV/1rP4KBgityKpc/
         q4ijbkkVvkdYAPnXnOwc1W8kJBPzTyK5IY81poIf18W8iFCSKg/4EB/orv0FvDflqyWq
         1jvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=HAXwkx/uYexRSiAooA8OWBY5Zfggqz9KkW8MSeKRhAY=;
        b=kVf8b1Eje9ec5Bu+6H9T/jgL284CR3h0UTRrjEAPNK+dqVw97gx29ra4CKOOx2benf
         VmIagIZ/zWTewVw86Omf9H0JAQWEUjzANbnx9APxmlID1oYDnByTewsiInkKMQDGym+b
         TJYXC51qzLH4Z/d/hMTc/DzDT3KwiCeX0RrJWShm55b5rXU+eEKu0CXXg00wXUndQYxn
         KUJrFTeK1Cde7HEbslZ0r7jhzY78KaGCKD06LZfAKfl1II2ZyUBSwo3c7j/EhrTDLtQ3
         GQ1P3HYXVWGxVa15VwfmXTiE+UvI/q6oecWI3a9on8pMM9kPEpnegvpAyQDwnp8+WAks
         IIBw==
X-Gm-Message-State: ACrzQf11KCRF4gv/dKDqxAbAc13iKBq6SSlzi1TXMTrkR0oQyAYQHN4H
        Th5CxUvaAuSVpCazwheo94o=
X-Google-Smtp-Source: AMsMyM5SfPUMVOrFRcI0rmr9hJJWrDmDA8GIlzElq1M6+d5Gr0O2I0uzleHg9lxYWYEQgu4T5bujeA==
X-Received: by 2002:a05:6a00:a83:b0:54a:e52e:9472 with SMTP id b3-20020a056a000a8300b0054ae52e9472mr1975111pfl.50.1663315888960;
        Fri, 16 Sep 2022 01:11:28 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id y8-20020aa79428000000b0053fa7ccf7e5sm13911747pfo.25.2022.09.16.01.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 01:11:28 -0700 (PDT)
Date:   Fri, 16 Sep 2022 01:11:24 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Lubomir Rintel <lkundrak@v3.sk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH] char: pcmcia: scr24x_cs: Fix use-after-free in
 scr24x_fops
Message-ID: <20220916081124.GA189795@ubuntu>
References: <20220916050006.GA188273@ubuntu>
 <d28d59c1-1ed0-422b-b749-0082de05e7ee@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d28d59c1-1ed0-422b-b749-0082de05e7ee@www.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 08:59:44AM +0200, Arnd Bergmann wrote:
> This appears to introduce a new use-after-free, when the kref_put()
> frees the 'dev' structure and you unlock the mutex in that structure
> afterwards.

yes. Every patch I've submitted has this issue.
I'll replace the mutex with a global variable and submit a v2 patch that fixes other issues.
