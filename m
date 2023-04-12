Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9337C6DE9A3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 04:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjDLCwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 22:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDLCwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 22:52:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8990A4C13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 19:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681267884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tcIwrcY+24AnNq9gPNPknyFD/pe/wpL86eaXxqmM7LA=;
        b=RpCC/6Sq+VpLj3h02UQm4K6XOWpVo3SsdupRXQZDT1XUevJXqVQNKIMn0m7NZHDvzG/TgV
        dJWw1JvW00vWy4ZCvdCvdVOVzoKntAmV4hNe8EaDr1+/7nchXtFGuRKov4U+oWgbGq0UZI
        Z01CvylCOhhkU9qGgY1cYAGC8gIkBzA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-XPJO4lnJOhqfmGpj9rNyhQ-1; Tue, 11 Apr 2023 22:51:22 -0400
X-MC-Unique: XPJO4lnJOhqfmGpj9rNyhQ-1
Received: by mail-wm1-f70.google.com with SMTP id k24-20020a05600c1c9800b003ef6ed5f645so1537717wms.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 19:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681267880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcIwrcY+24AnNq9gPNPknyFD/pe/wpL86eaXxqmM7LA=;
        b=DNkQOzZbZhinSY4WXpaXO3rlz4NQbwkdXfSdx50iATTclBqoQnf68orN/uxaEQ3vR0
         9oNEaVMkNXxSe1MF3E8xtfRbdmSZdHodgnX9OHrfZ65OecT+4njzu3Z21cvW1tMiUIzZ
         GUGL/csu2PpiGkns0wGbGJDzUeMCJZKS3Ol8q3e8NQTUEt0OYb12BT3BnIEo/CxKns8k
         CGWwa+WfcCG6hbfhB6ot/cVTLrU+Nw8c3mhl3aIDsregz5yTRnMwOAK33gYoJJFzrvE8
         3RBOHdgMUxZUAj2i8svJDWQa72YclYwE3y9BtxyCWHQCszdyFqOgP8hg4+amUOUE9aP/
         93JA==
X-Gm-Message-State: AAQBX9dmHo9LDQtEm5n1/UQ7mrl9CQUJqu78O2gh9+yGcHINlcFtCpRG
        XaBWa0TvbyNLvnxyHBuIIWf7BIESNJ6tcYD0gK1GbfdEX1kiQKRcGUjI3F6e4bkJhPCV+t4FmLe
        enaMOj5XMOpPRMVEr4XDBBDPlP0SZLK54
X-Received: by 2002:adf:f9cc:0:b0:2f4:7980:cb22 with SMTP id w12-20020adff9cc000000b002f47980cb22mr328827wrr.18.1681267880807;
        Tue, 11 Apr 2023 19:51:20 -0700 (PDT)
X-Google-Smtp-Source: AKy350bnBwBEZSLFNp0J/adhIqRltE3YnYlqEiMeksVUlii2FQ0Z7HYqw8kjhzLXjGLZNhdxaf3JqQ==
X-Received: by 2002:adf:f9cc:0:b0:2f4:7980:cb22 with SMTP id w12-20020adff9cc000000b002f47980cb22mr328821wrr.18.1681267880534;
        Tue, 11 Apr 2023 19:51:20 -0700 (PDT)
Received: from redhat.com ([2.52.10.80])
        by smtp.gmail.com with ESMTPSA id j16-20020adfff90000000b002f2783ba25asm5464259wrr.65.2023.04.11.19.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 19:51:19 -0700 (PDT)
Date:   Tue, 11 Apr 2023 22:51:16 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the vhost tree
Message-ID: <20230411224945-mutt-send-email-mst@kernel.org>
References: <20230411151953.182c6a92@canb.auug.org.au>
 <871qkqawqr.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qkqawqr.fsf@meer.lwn.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 04:18:36PM -0600, Jonathan Corbet wrote:
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
> 
> > Hi all,
> >
> > The following commit is also in the jc_docs tree as a different commit
> > (but the same patch):
> >
> >   3a9421482150 ("dma-api-howto: typo fix")
> >
> > This is commit
> >
> >   2ca956cf8834 ("dma-api-howto: typo fix")
> >
> > in the jc_docs tree.
> 
> Michael, I'm a bit confused by this one...you sent it to me, but
> evidently didn't want me to take it?  I can certainly drop it...
> 
> Thanks,
> 
> jon

Sorry, it's just a holiday here. dropped now.

-- 
MST

