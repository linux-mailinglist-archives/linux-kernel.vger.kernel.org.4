Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA00607BF1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbiJUQRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiJUQRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:17:15 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97B121345F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:17:12 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id f193so2996586pgc.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a5HwjrEsbZ06mtwjRmKc4OTOM9VDMQ8gzVbnsFrHZGA=;
        b=kyBgeRNVpPf/+eXjNWn65VlUrSqNsGqjPFtMYOaqRVFLwdPydK/8yWXIZzuDfhzfU5
         LC4RwAymTmM9iT1vywnM2HLhDMbzxKM66c/hOsP+f9KVoy0wvICCh7b9Tt0HJKVi7Eos
         qkZ0AXkOg3UND2knqk7S46zKAxzGzsYdrAMm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5HwjrEsbZ06mtwjRmKc4OTOM9VDMQ8gzVbnsFrHZGA=;
        b=IsCf7+r+bkm+Xf9YtFOZWeebuxv+leA5rOcPuXIzcnSeFdrAWo8EjW1hSxFaJ05dWJ
         18JHyI0jKFKzJI99h/kcsXSmKitQ53D7xPB++ztptP4Yp/M7b6Sz6ZKXacOML04wlhbp
         dr66U+nmHOgyhNUuwzm5lFGumkwsJA84q9lyHP4BC0Iry6oCnOno+ncj3kUE5nwHeG1r
         juqf76TZY752/AEhC6xg2Q5j+VJ3pStM1JY5831zUue1m66BFsA5wM2Guv2IGFxes/kH
         4Sqr1PeUBzRjQ/GRvXJSyq8R6un3WiGC7ozimz5vLS5QyBV+o6s/25JeYxb9q/+kbv7A
         p2Ow==
X-Gm-Message-State: ACrzQf1DIG5kOx9gCX89IHfAP8nxA0C3W/6VGw4V/BWqT87QYIGbIoTz
        j/GKDeAN9K5pix0RUj0/5xC+9Q==
X-Google-Smtp-Source: AMsMyM64Or+Td8E+kV3nCHTUjyveWm5i1vbiel8OqdocW5woDhFBuqDDrj7pqamKaSO8jyNxwlC9Pw==
X-Received: by 2002:a05:6a00:be8:b0:56b:2c80:31e0 with SMTP id x40-20020a056a000be800b0056b2c8031e0mr2146538pfu.44.1666369032312;
        Fri, 21 Oct 2022 09:17:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l1-20020a170902f68100b0017d12d86901sm15260123plg.187.2022.10.21.09.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 09:17:11 -0700 (PDT)
Date:   Fri, 21 Oct 2022 09:17:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jinpeng Cui <cuijinpeng666@gmail.com>,
        Zeal Robot <zealci@zte.com.cn>, alan.maguire@oracle.com,
        ast@kernel.org, bpf@vger.kernel.org, cui.jinpeng2@zte.com.cn,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, stephen.s.brennan@oracle.com
Subject: Re: [PATCH linux-next] kallsyms: Use strscpy() instead of strlcpy()
Message-ID: <202210210915.B177280DA8@keescook>
References: <20221020090547.398680-1-cui.jinpeng2@zte.com.cn>
 <Y1EVnZS9BalesrC1@kroah.com>
 <CANhqVYZ+trZzPdB=Vd9YV53DAJt0p5LZQH-u94+VRrDQ5+w2MA@mail.gmail.com>
 <Y1FCiH16RIetS0hZ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1FCiH16RIetS0hZ@kroah.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 02:43:52PM +0200, Greg KH wrote:
> > I am very sorry if the patches from zte.com.cn
> > in the past few months have made you angry,
> > we have decided to fix the problem you pointed out
> > as soon as possible.
> > Our company's mailbox name@zte.com.cn
> > cannot send emails to the external network,
> > so we use name@gmail.com to send patches;
> 
> You all have been warned numerous times over many weeks and months and
> never responded to our emails.
> 
> We have no proof that using gmail accounts is actually coming from a ZTE
> employee, so until that happens, we can not take your changes (not to
> mention the basic fact that you all keep ignoring our review comments,
> which is a good enough reason to ignore them.)

Aren't there a few solutions here?

1) Just send the emails from @gmail with matching S-o-b.
2) Send an @zte.com.cn to lkml to confirm their @gmail/@zte.com.cn mapping.
3) Fix the email systems.

-- 
Kees Cook
