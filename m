Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06DF6F281D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 11:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjD3JLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 05:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjD3JLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 05:11:44 -0400
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AF51B0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 02:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Reply-To:Content-ID:Content-Description;
        bh=PTKOCu+q9XbmKYiaY3NFdCKMu4iSDQxTN+mg8FMfkbM=; b=l3ipX5P+95J3/iyM9zjkifHklP
        2JXZraPlOFaTO5IkB9VYt6xct/NswagJ/Kw8SkstDBBfyYK8KBH+MHtOFoa49u5BhRRfTjSFrjCl5
        LlJ4C+iFEp7uMnwgA9iLiYL00R2go86e+Ygeo6Lgy77Gjx2JbH7fUqZWLyAoG7MFa1+XTmvApo5A+
        Xd59FAG3vZ0DOc+KZ1YwIC7Kd8altuohX0YzHXo0hAQtpNHCgheoy7YUpZdurh/aSE+mVOa9zPZw1
        /1upaDzVDNl9smoGCY3cm8iKtR91egmmiOvlgc5z90CyqpA7xKEPwWlxIQfq1LnnJ1sf7RTt2MEQZ
        pHCSJifg==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
        (Exim 4.94.2)
        (envelope-from <ukleinek@debian.org>)
        id 1pt35d-000foy-Ft; Sun, 30 Apr 2023 09:11:28 +0000
Message-ID: <14858d07-abc2-48f9-329a-6d5a4faceeb9@debian.org>
Date:   Sun, 30 Apr 2023 11:11:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] tools lib symbol: Use -D_FORTIFY_SOURCE=2 for non-debug
 builds
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Diederik de Haas <didi.debian@cknow.org>
References: <20230424102827.58707-1-ukleinek@debian.org>
 <CAP-5=fUOL0FmtMbLQtRx2-_i6uvbsBLsxaAg54x8umT4npT7iA@mail.gmail.com>
Content-Language: en-US, de-DE
From:   =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <ukleinek@debian.org>
In-Reply-To: <CAP-5=fUOL0FmtMbLQtRx2-_i6uvbsBLsxaAg54x8umT4npT7iA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Debian-User: ukleinek
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/23 23:05, Ian Rogers wrote:
> On Mon, Apr 24, 2023 at 3:28 AM Uwe Kleine-König <ukleinek@debian.org> wrote:
>>
>> Commit 160be157eaba ("tool lib symbol: Add Makefile/Build") failed to
>> define _FORTIFY_SOURCE to 2, probabaly this was cut&pasted from other
>> Makefiles with the same problem.
>>
>> Fixes: 160be157eaba ("tool lib symbol: Add Makefile/Build")
>> Signed-off-by: Uwe Kleine-König <ukleinek@debian.org>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks

> Same problem here I think:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/lib/api/Makefile#n42

Indeed, and similar patch here:

	https://lore.kernel.org/all/20230424102049.58338-1-ukleinek@debian.org/

Best regards
Uwe
