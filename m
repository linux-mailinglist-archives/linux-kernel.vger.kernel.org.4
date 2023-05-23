Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3ACD70D9CF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 12:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236494AbjEWKDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 06:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236453AbjEWKDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 06:03:33 -0400
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9E5126
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 03:02:58 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4f3b9c88af8so3357443e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 03:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684836117; x=1687428117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nNQVJ3hfapo341FunxfExex277Zhp8AOqeMr7BSJi3A=;
        b=DpfQyv9LjpABrMFNZLkTqBOe1d0NIK651tomV1gk59doETORebQ6fh8QDpVbbPEIXG
         3t+trILLiyi1zQp6Vcs2aCqc0e4FSZD6F2QWwKpnIESv1YEFlgC21bAMFESW6JmRzdP2
         7cRhYmMmIRDmLdIw0gEwy5p9z6a7F+nyP09sZhgJncyIEy84frqsy1eIUcb6pHR2ENuD
         etIWMxWU/7jjS5gbtLfNKwSyb3TbZGrfd524aQ0C/s+fNV0jKN1xNml4NahsNw+xFuKa
         t4Iw0dD6dOuhr8VlvZiaU709ts52RnyR5xvMFtUfgFMEczfHs8Tp7m456kQrDpPri8MV
         Dj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684836117; x=1687428117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNQVJ3hfapo341FunxfExex277Zhp8AOqeMr7BSJi3A=;
        b=CAQrzwpVxV1kLbkuxhU2X/jEkIl4wlw2T54ZVp0WhbPlVYbO6o6Ps7adQ98/HrpzMd
         +teqr6GtNLWa7uI73kQ4CE8ntk8S/Xv01egKE7owoF/Gq5rp2D+wdK7Xw+jZFDOTkvgX
         6j9gxFpvsJ53BJMFivh+ChlMtMtnlMCSoVA4ijrEeL7g5GTH7x48CzvJjKOWAoJMS+0s
         19SyrcFzG/fqYKmFRXpSDQ73kb2++FFPTbabS/8mvXNl0X+Se8qDU2l+ku15lvMnUJjF
         51iRz5+lfo6Wx42US0g0l+rOTfjdLnRJAUJ4RvcnORg7hSeulYjJdazYYPqdzytJiMQE
         9suw==
X-Gm-Message-State: AC+VfDznpIy2CXP1xzwX8Idpx74YwrArD3WVDMpQPnwbVPQUgKjuAPJG
        1wSleliIxbLMbr8VjJ8mKKI=
X-Google-Smtp-Source: ACHHUZ7gbRP2buKWjCezQBVAhmc8Agm+5TnQRbjtDxRf+Rye18MC3dsyc6ASWaXXejsoiCYbiwpFdw==
X-Received: by 2002:ac2:5298:0:b0:4f3:7c24:1025 with SMTP id q24-20020ac25298000000b004f37c241025mr4301335lfm.26.1684836116411;
        Tue, 23 May 2023 03:01:56 -0700 (PDT)
Received: from pc636 (host-90-235-19-70.mobileonline.telia.com. [90.235.19.70])
        by smtp.gmail.com with ESMTPSA id a5-20020a19f805000000b004f2b6a203aasm1285696lff.224.2023.05.23.03.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 03:01:56 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 23 May 2023 12:01:52 +0200
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/9] mm: vmalloc: Rename adjust_va_to_fit_type() function
Message-ID: <ZGyPEIkaG8RK9XYY@pc636>
References: <20230522110849.2921-1-urezki@gmail.com>
 <20230522110849.2921-3-urezki@gmail.com>
 <ZGxX569FVffCl7R/@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGxX569FVffCl7R/@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 11:06:31PM -0700, Christoph Hellwig wrote:
> On Mon, May 22, 2023 at 01:08:42PM +0200, Uladzislau Rezki (Sony) wrote:
> >  static __always_inline int
> > -adjust_va_to_fit_type(struct rb_root *root, struct list_head *head,
> > -		      struct vmap_area *va, unsigned long nva_start_addr,
> > -		      unsigned long size)
> > +va_clip(struct rb_root *root, struct list_head *head,
> > +	struct vmap_area *va, unsigned long nva_start_addr,
> > +	unsigned long size)
> 
> Same comment as before, not going to repeat it for futher reviews.
> 
Fixed!


> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
Thanks!

--
Uladzislau Rezki
