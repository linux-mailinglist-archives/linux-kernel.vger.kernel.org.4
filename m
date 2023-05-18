Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D05708658
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjERRDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjERRDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:03:44 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCF9121
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:03:42 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d24136663so502376b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684429422; x=1687021422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mFceaARxyb9W7/v+8bZC590WjVR8FWQcW9h7CPg1Wo8=;
        b=jS12OWi3qESMpy5AC91I/uif4oFEdwkFofQ6bGm9PloqZh/38edoj0eqxssU5uRZHV
         QK8LlzgvmSOAIopR4VHtA+XcWn5KxC7jSxvY6GYKTvu0NLbJE/ffSvLihbUYAOia13/t
         qhjRJ84BQVZ62rzpMV8v3sIfUsQtsCnBxOdVNxi6xMw8VFHQg2Tw5GPGpy3/21d3Va1O
         H+W4Szq1rm6dIMN8qwWrvnyAvnWuUFCM//mYxF+KeDKY2YPQPJqtjH9keX5S8dR3LtRA
         csxTVdsnS2v9Ll2j4kaZDCScza6FNIerqCCfSbRXB7/hmHxR8VT5R7mY7LYK8dB1mb2s
         A/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684429422; x=1687021422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFceaARxyb9W7/v+8bZC590WjVR8FWQcW9h7CPg1Wo8=;
        b=hpilw6S7npbzNzXynDPZyKy8SOmkypnKM3Qid0PBn8654iimbC/hfVrq0bj5YcihAh
         pdSnvM1PUE+9Kj5B3h5XhDDlblB5qLG3VRehiYKhCUmx01StrB1awH27GBa34H2HO3aM
         90auMu9SVxIV63DuEiO5ZdvKwmJq/39nNcgPLOw7lMiI1/XF53Q0Sdy/2Sp/9S+Uofy2
         Hk5F//PlsUgwnZ94JR8R0swZpnvdfRweA7rO7czJRYq1D5hsHlvwAPg8VfAULy1v/wjT
         rdgC6QWC2Hd+YK78aJGs8pO/IdrU6xxWsWMasO4NhXTISkyoTcZ2LZKngHR8hCoabqzE
         ipVw==
X-Gm-Message-State: AC+VfDzKDlTKYoMXky1Z+GS2NyaNb1Mgzp8GLl1LKOG/ZRtYvocg2rjg
        DLsjog83gjVbKlmASo61oOlgAA==
X-Google-Smtp-Source: ACHHUZ4tyztPHVx6beTRkxTFviBuW6zoOlvhkbBy7z8/t6upoKovKWcp6afnjSKhu0KcCkiZItZHXw==
X-Received: by 2002:a05:6a20:8425:b0:101:962b:8dc5 with SMTP id c37-20020a056a20842500b00101962b8dc5mr475983pzd.36.1684429421872;
        Thu, 18 May 2023 10:03:41 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id e21-20020a62ee15000000b0062cf75a9e6bsm1555954pfi.131.2023.05.18.10.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 10:03:41 -0700 (PDT)
Date:   Thu, 18 May 2023 17:03:36 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 2/3] Revert "android: binder: stop saving a pointer
 to the VMA"
Message-ID: <ZGZaaGH4YfvcV4iy@google.com>
References: <20230424205548.1935192-1-cmllamas@google.com>
 <20230424205548.1935192-2-cmllamas@google.com>
 <20230424223419.6n2z72mocgmcj3aw@revolver>
 <ZEcMhOywwzsc6CN5@google.com>
 <20230425014328.d6vvimziv6je5xdg@revolver>
 <ZEmU8ULSEQhDVyX+@google.com>
 <20230518144052.xkj6vmddccq4v66b@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518144052.xkj6vmddccq4v66b@revolver>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 10:40:52AM -0400, Liam R. Howlett wrote:
> 
> I came across this [1] when I was looking into something else and
> thought I'd double back and make sure your fix for this UAF is also
> included, since your revert will restore this bug.
> 
> I do still see the mmap_read_lock() in binder_update_page_range() vs the
> required mmap_write_lock(), at least in my branch.
> 
> [1] https://lore.kernel.org/all/20221104175450.306810-1-cmllamas@google.com/
> 

Thanks Liam, I believe you are correct. The UAF should trigger on newer
releases after the revert of your patch. I'll try to reproduce the issue
to confirm and will send the fix afterwards. This was a nice find!

Thanks,
--
Carlos Llamas
