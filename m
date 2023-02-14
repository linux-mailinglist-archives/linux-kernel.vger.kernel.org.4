Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3699A695DA0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 09:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbjBNIxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 03:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbjBNIxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:53:33 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22088358E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:53:21 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id eq11so16285010edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QIYxPxqTVC5q5fqd02aQT5nCt0EynMIyaITIVDDbF0c=;
        b=pJJ0eGxBmLWD2sppH+EGcOt+KkHj00o0ktEdp7z4RenBhljzYu2wy93IO4T7vxoseg
         hmBuIftgWeEfN8lcYXinouLy8XwIhGTh+jq+16I6MneOFeMiYsdFiChemx4wFXHtCGsR
         6q008NaZ44f4QpTV49t2MjNAljF8etbKVQBZnyO9gyy9MFJVo6ozXWIJZoYh08vOUw3b
         Rk7grA+41EFKe0N+5OVZnzzR95r64tNrGGYYcOMcgIiMuF+VG7ZascdzLDF7ot481i1i
         jGs3zsHclNbLj4s6ojBmE4aw1ObDETmqgQ2O8iKsz59FOYFJjhHiZdqchtdtXfkBnjRd
         Fv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIYxPxqTVC5q5fqd02aQT5nCt0EynMIyaITIVDDbF0c=;
        b=aEQyrFZV4di0lmrWJaZTXsDlH8G3a9GQrNZooCBuDsWx5W+MQJmlFOZq+qBYILK1wA
         6Etm1BpB5QASh5aQbU9I+q/FsIe70xezaxUYOtASmxS7d9lAKE3E2dgd5vXOxN/iFLN2
         dHSsfI0/RBuDYxBFHSmW6yiMXjIImOQh5rFYzLEEVvJINPCKqsvJneutGQaDnRMpA3Wd
         I59NC6WmTy0bRuocn9hAhe6Z/UzzxDf77IU6Y9UrOz0CXxThSd3YgY3bQZpcPYIZEkGl
         ZRcD8o0YQjtuqWsQ8wc3pS+1fYyOIdjw/xkj+RHxb0qLSn33/o8D/7e8mA629uGtuVaA
         ni6w==
X-Gm-Message-State: AO0yUKW9gSdWElefO23KYbzctGEK6y37Xe5UDOxGNs1HiQhdqyRCCwxJ
        CPBileMpIyPBSSc8nOnlHAGDgQ==
X-Google-Smtp-Source: AK7set9u+UXEPwzxaUDlBLvd1Of1I461QnUKJUx6PfQxlx6CmiRi3f6fgGlxoqtj9g0j/1Z/ajLi7Q==
X-Received: by 2002:a50:bb66:0:b0:4ab:f03:8cbc with SMTP id y93-20020a50bb66000000b004ab0f038cbcmr2019198ede.13.1676364799709;
        Tue, 14 Feb 2023 00:53:19 -0800 (PST)
Received: from jade (h-46-59-78-111.A175.priv.bahnhof.se. [46.59.78.111])
        by smtp.gmail.com with ESMTPSA id 29-20020a508e5d000000b004acdef7baaesm463403edx.96.2023.02.14.00.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 00:53:19 -0800 (PST)
Date:   Tue, 14 Feb 2023 09:53:17 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-mm@kvack.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH v2 0/4] Remove get_kernel_pages()
Message-ID: <Y+tL/aPwD3ElBhLQ@jade>
References: <20230203-get_kernel_pages-v2-0-f1dc4af273f1@intel.com>
 <CAFA6WYM5tzs3T1tDgspA=R=VxfWrknm2YPHMCZihx405pF-ftA@mail.gmail.com>
 <63e279f730612_104ce22946f@iweiny-mobl.notmuch>
 <63e6a8b798a_145760294a6@iweiny-mobl.notmuch>
 <CAHUa44GAM=meibiSDjjWb0wKmHzud6JddE3W=zG3XCFfgP+Sag@mail.gmail.com>
 <CAHk-=wh3+moi98rbiMnwnxPNZcYBaVY57TM2EP6NgXgNwFeP7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wh3+moi98rbiMnwnxPNZcYBaVY57TM2EP6NgXgNwFeP7Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 11:02:52AM -0800, Linus Torvalds wrote:
> On Mon, Feb 13, 2023 at 7:02 AM Jens Wiklander
> <jens.wiklander@linaro.org> wrote:
> >
> > Sure, I'll take it. The timing is a bit unfortunate, it's likely too
> > close to the merge window to be included there. However, I'll pick it
> > up and add it to linux-next so it's ready for the 6.4 merge window.
> 
> With this boeing almost all code removal, I'm perfectly fine taking it
> in the upcoming merge window.

OK, thank you.

Cheers,
Jens
