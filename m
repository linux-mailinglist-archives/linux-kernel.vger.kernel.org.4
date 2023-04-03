Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A336D5202
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 22:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbjDCUIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 16:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbjDCUIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 16:08:39 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884A346B4
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 13:08:16 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id q5so10540039ilg.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 13:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680552496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lzf1hVGn2U0kIz5uFFTGiVEn901rxiPey+rVdsOHESU=;
        b=r5i+02NyxpT037diZx+i0xbDImFGRilO1cQxzS4uwF6udbUygql1xWTUvW8dADd0hW
         /4GIBouHtw4OGdzkAv4mnixIX6euyKWYYAvF3CH2vSzgbvr+o09Dt3sGDlID8m04ziyC
         iz3xVlvzVkSM0rjC182W+ejYUW6/Y74BvAHYKoY2NjDsPhsxE2sd4YQTnn81YHIo04vK
         OrMwpNoWBfx5/TdgTzlOyBXijWLapS3xaYizckSvANurpdAmBw3wJ5ckCt4HRHGA+GXh
         t5QSJ1a0q9OgHcWtahmJ99E0H5vuQQ2SoUfG78wV1xhXawKqqFcuq78auRfo93lRfvtd
         NfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680552496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lzf1hVGn2U0kIz5uFFTGiVEn901rxiPey+rVdsOHESU=;
        b=fkVbmkETimLGg3VJ77TTAHEI6eqRjndgTD6HXvuFgaiMAAFJIfyBDimHx9J8Qn6qJu
         QyByv3QFs1x/QiD5hdX1mczNCcuZ3w/Xd1O/M4IiubcKIAoy3n9XnrxdkYwgAry3WmAm
         c8S5cDqeqKNW+MVrFT1VqVsw5c3bRjgOiAoOeyGHiTemkFI7/PKoB3PLbFhf3HT5zW7Q
         MKAvNidFmMWmbMww7+mn08CwjCc6+vfW563HDPNq/2xbSDJhkrrvRaHqVngXu28B0wZ+
         HTgrsjK8C8L6BuLIglHpngcKIXont31Xz2KywYvT0ZQO+zgvvQWhmz74L9kUXFgndsy/
         u3BQ==
X-Gm-Message-State: AAQBX9cDNw0NdK59/wChb8wrZg6gbbiu5OLtGsnUBQrMPvIa5Cg2MY4m
        oSL73ONu5aEzRfcAlhZ/W72jObeAVAv3l0fc+kWSGg==
X-Google-Smtp-Source: AKy350Y0TvCsrt+7epBO9kp3gIT/PDHTRFUp2lRZxuj0ptFrpqn6GOPJ6ia2lDvPgPh9kavgeocT/g==
X-Received: by 2002:a92:d2c1:0:b0:325:c1ef:5943 with SMTP id w1-20020a92d2c1000000b00325c1ef5943mr202510ilg.14.1680552495746;
        Mon, 03 Apr 2023 13:08:15 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:e7f1:d2c0:8bcb:e706])
        by smtp.gmail.com with ESMTPSA id i18-20020a926d12000000b003261b6acc8asm2795691ilc.79.2023.04.03.13.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 13:08:15 -0700 (PDT)
Date:   Mon, 3 Apr 2023 14:08:11 -0600
From:   Ross Zwisler <zwisler@google.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the ftrace tree
Message-ID: <20230403200811.GA1121882@google.com>
References: <20230403145115.2849e079@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403145115.2849e079@canb.auug.org.au>
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 02:51:15PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> The following commits are also in the mm tree as different commits
> (but the same patches):
> 
>   4336cc15b9f7 ("selftests: use canonical ftrace path")
>   d1c27c55427e ("leaking_addresses: also skip canonical ftrace path")
>   c2f92e8b2d24 ("tools/kvm_stat: use canonical ftrace path")
> 
> these are commits
> 
>   7dcf5bf9ae8a ("selftests: use canonical ftrace path")
>   4ea6b3463c3e ("leaking_addresses: also skip canonical ftrace path")
>   d791c1b3e996 ("tools/kvm_stat: use canonical ftrace path")
> 
> in the mm tree.

Thanks, it looks like akpm dropped them from the mm tree, so that conflict
should be resolved.
