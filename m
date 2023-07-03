Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C66074632F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 21:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjGCTIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 15:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGCTID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 15:08:03 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33208AF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 12:08:03 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-55b22f82ac8so2810927a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 12:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688411282; x=1691003282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1sAcjD/xH/4W7vgxlw+9dERXyd7eoJLIeev4bwq0Dpw=;
        b=YtVjetfu+zgyqggr8pSONDAQDJO+y3R294u1pUxnx0G0JbgVXGaAmjMPSvXOnmr5x6
         1Bn4zC+zKc/fTqlOhk2tinAXV/jYRxLPWUq2H0+uZWHb/G96x2cIL/0ng/EduK84xZwt
         02eE2nyTbQ92wNOFMOTTslOl9tywr+6t94XZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688411282; x=1691003282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1sAcjD/xH/4W7vgxlw+9dERXyd7eoJLIeev4bwq0Dpw=;
        b=Tb3YBzwTecwfChaf4XHsn0iiCngYTs4KQpJJ0YLL3cmJW5Tjax4jBxhOLPMW6zJ95q
         JWICV4mNPMQl0Kbsvh2RdpYG6b1oi2t1VFLo7cxVzCy5lFqiz5q7Sl6hH1Vziq6Q7thd
         RnlN1tyeZWozq9zz8gXo8HykhvSYV4bFWDGt8OGywTGAJlqX6IumLKn5bCvoUMuy6iQs
         L3aDR/Gq4ULgeDIulccA16AT3R70IaevMrcUp5F8pX6J8q8PKfTnA1moWb9XQFgZ5LCP
         ReVBUr29SYb1tEsSbWMuMnYVVG6EIg0JEps8T3K0+yapm+GiuReRi61II4DkKR64D44y
         c22w==
X-Gm-Message-State: AC+VfDxgGmqaHNBR70xOU1LYZtdv8UjnDxdVe59rIxuIeaZOiPMqKwFt
        uE8i3INT4MdKkz8mK1X0/Mz2BmhMHGZplT1f0ag=
X-Google-Smtp-Source: ACHHUZ7PR1gWvioKKWwPqN49Ysfnr0XtGs+suZZ377D2I0CTnJQBnRVt3pXg3zAWT/Mg46TO+9+Pvg==
X-Received: by 2002:a05:6a21:9985:b0:125:4d74:cd6a with SMTP id ve5-20020a056a21998500b001254d74cd6amr21808334pzb.3.1688411282617;
        Mon, 03 Jul 2023 12:08:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q136-20020a632a8e000000b0055b0c330b30sm10556753pgq.84.2023.07.03.12.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 12:08:02 -0700 (PDT)
Date:   Mon, 3 Jul 2023 12:08:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/bench/seccomp-notify: don't use assert to check
 syscall errors
Message-ID: <202307031207.2F2BFFF9@keescook>
References: <20230630051953.454638-1-avagin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630051953.454638-1-avagin@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 10:19:53PM -0700, Andrei Vagin wrote:
> Since 616b14b47a86, perf is built with NDEBUG=1 so the macro
> assert() is nop.
> 
> Signed-off-by: Andrei Vagin <avagin@gmail.com>

Thanks! I've squashed this onto the patch that introduces the benchmark.

-- 
Kees Cook
