Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7682771509B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 22:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjE2Uhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 16:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2Uha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 16:37:30 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBB7C7
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 13:37:29 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-510d6b939bfso6712470a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 13:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685392648; x=1687984648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oPwps85VxBgJKi9188OyKv6KoEbbCOt8E4J6ugG8b2o=;
        b=CF3hTrJkMdxHRs/fZi3LdrEv7bci+w0ChwVh5OzY2tGDOL4YGIZ/UW8T2Xnx7ssde3
         05IXyV1rXLCR+dXQZRfm7ym7bdud+sMZWozXUhnmqWZXOGQT0y+llbWDFTeTt7AIv1UB
         +hfu3kH4mYGykuseVwo8aqnVmjwDNnV0DvlbtsPN12N4hUXYspPdNi01hv/GVWUnjhXD
         knM0ZvdLKezp3MZGC424P1prhh8MPZH6JzUKzNuLonagMJ3HxdRhMeBiXoD7IXKuS7D7
         P+WpAD31YI80QVpajYy8JcAUa7HY7YY0Cg0wPvlxXJ5udlSBwh1Xp2sjgjuXGvQP4WL5
         +fVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685392648; x=1687984648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPwps85VxBgJKi9188OyKv6KoEbbCOt8E4J6ugG8b2o=;
        b=Rgsobj8k0zn2wAiIxil3MCWKxwD2S4521ECaBRrzV4l2K7tL4vfiSVp50gJjquNuwI
         n9CIQWvpxffQtG/lZWTO0CzUaY/ilSJ2/mqTNehgeUQ01uOYp6/T4lL1o1a4aYjBogLm
         X2p9ta6PdfUcKYY1azq9xZKACebMEq/KvVABUSWWkoCNoY1/1GPXySpeFNQeiiZpFvk9
         HHIfTZFYlf9E+h3M6+FBSBIbYPRBX1IkSN1DWJ2RIYjsSRUa2YsVyAPHD/reZ3u+kQ+C
         ZY8B+MMS8eCx0as1MAjW/8fFS9+qX5MJYLMGgZfVyB0KlkoWdXtXsBRMLVZZ6OUBiac1
         VHaQ==
X-Gm-Message-State: AC+VfDzMeArbSh7Y8ggr78/kZRc6O/vMIKN8cNijpJE1t7hnuPdfdSak
        2D07wFPN0+Qqb+rO+f+O8f8PjCcbGGY=
X-Google-Smtp-Source: ACHHUZ6sajz4xoL6oWZrhdc71ANwFQb3t64sKC0XPEeCgOVr4BLkjlT3tiYwQB2R/K8WOZyv9m447A==
X-Received: by 2002:a17:907:a422:b0:94e:2db:533e with SMTP id sg34-20020a170907a42200b0094e02db533emr365662ejc.49.1685392647816;
        Mon, 29 May 2023 13:37:27 -0700 (PDT)
Received: from pc636 ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id uz28-20020a170907119c00b0096a742beb68sm6242529ejb.201.2023.05.29.13.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 13:37:27 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 29 May 2023 22:37:25 +0200
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/9] mm: vmalloc: Rename adjust_va_to_fit_type() function
Message-ID: <ZHUNBQMwoRXET8bS@pc636>
References: <20230522110849.2921-1-urezki@gmail.com>
 <20230522110849.2921-3-urezki@gmail.com>
 <7afd7647-15c2-4398-89a6-ed50b4115b84@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7afd7647-15c2-4398-89a6-ed50b4115b84@lucifer.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 27, 2023 at 10:50:22PM +0100, Lorenzo Stoakes wrote:
> On Mon, May 22, 2023 at 01:08:42PM +0200, Uladzislau Rezki (Sony) wrote:
> > This patch renames the adjust_va_to_fit_type() function
> > to a shorter variant and more expressive. A new name is
> > va_clip().
> >
> > There is no a functional change as a result of this patch.
> 
> Small nit - I think:-
> 
> 'This patch renames the adjust_va_to_fit_type() function to va_clip() which
> is shorter and more expressive.'
> 
> Reads better here.
> 
I will update.

Thanks!

--
Uladzislau Rezki
