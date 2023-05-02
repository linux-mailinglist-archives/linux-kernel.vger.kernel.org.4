Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8D06F461A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 16:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbjEBO2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 10:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbjEBO21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 10:28:27 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9872DE4
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 07:28:26 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50bc075d6b2so5638913a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 07:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1683037705; x=1685629705;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7FKGh0V/sUkPWterLgeKMR0qmICIRS+Z+OogZTBc8A=;
        b=HlUiVG7kJ8etI4PlTw9fyFgYDPGuNEm8jbGQDt/54lQbEX7/rdTugwTwJ0+Jfh2ZXu
         mi7gVIO15zRJRW9RqmAHz3DUWJYWhejqQ1p6B6AKzMuyKpDPPM3TGXx+SRNUX9JW7xt/
         FfaDYF1dAnv6iV/K1OF8UXozjUlh5aC4OXIK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683037705; x=1685629705;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7FKGh0V/sUkPWterLgeKMR0qmICIRS+Z+OogZTBc8A=;
        b=H4bSX7TjMWWo/RJCLu3UTF7ArL+v1Rw5n58QmiQKE1u0ycmkzd0HrjnOJMfAr7I+j5
         dNqPqtLUS95ke1oMkz6E301iu4AWbqvc/74xR5JnJH6TJcoSd2wxVaTfADvRdszrprEQ
         d31i/LznDDoT6Cbfg4oU6idnw6KX1mPnR4frbarkjardWC5vPBx5t35z13B8VBE2PrOu
         naPcJ1KoqN7oEdgf/ujuGdh+YYWInMBfWPduw/HO8IQbATzcIhOPmb4/DBfy5ZJ8Bwdg
         tocrtAOaiuIcmHhyuT8Dz0L865xh6ibrEtKkzgZfaj0Pf5rL6npWKr5mfRcTiIL3wOhG
         RAeg==
X-Gm-Message-State: AC+VfDxcq0gNIPzPtoAOPju0u5P3e6vPzLxNpahVbU66dJEqKH7eGgGg
        1u5mB6Xbedvc5QaxjzsuU5FVwA==
X-Google-Smtp-Source: ACHHUZ5BgMTWB1+CTnJvrrnc0aPq94/OCXPHLcjvEj1Q2rw13mEFCJYl51jUtSHUdqN0+g2LUyDqug==
X-Received: by 2002:a17:907:6d0e:b0:94b:4a4:2836 with SMTP id sa14-20020a1709076d0e00b0094b04a42836mr86207ejc.69.1683037704988;
        Tue, 02 May 2023 07:28:24 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::6:6408])
        by smtp.gmail.com with ESMTPSA id mm26-20020a170906cc5a00b00961828830d9sm2976303ejb.35.2023.05.02.07.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 07:28:24 -0700 (PDT)
Date:   Tue, 2 May 2023 15:28:24 +0100
From:   Chris Down <chris@chrisdown.name>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: [PATCH v5 2/2] printk: console: Support console-specific
 loglevels
Message-ID: <ZFEeCANq-F7JODRD@chrisdown.name>
References: <cover.1682427812.git.chris@chrisdown.name>
 <4d3846bf2543de20aa071b2a12de924eea3e9574.1682427812.git.chris@chrisdown.name>
 <ZEp9dXwHCYNPidjC@alley>
 <87v8hhs57d.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87v8hhs57d.fsf@jogness.linutronix.de>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John Ogness writes:
>I agree that we should go with your 1st proposal. But I would like to
>see some comments added into printk_get_next_message() that only @flags
>and @level may be considered valid.

Thanks, will do for v6.
