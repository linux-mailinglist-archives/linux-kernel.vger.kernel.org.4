Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9655D623ED3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 10:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiKJJk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 04:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKJJkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 04:40:55 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1CC6A6B5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 01:40:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BB3141FE99;
        Thu, 10 Nov 2022 09:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668073252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QqANZU+pw5gBuNdePRxF8GAA+MvsR3exid0Kwc/0Xo0=;
        b=Oz3a1AeNtTRxZNZpnqPjGwghw2xra9e0bS75O1suM2Voh4lJCNJPFLk3OCjOd/1r/jbaxV
        XVKcyCtPQQpPmRZXzPq/t7/gQ90qr3rjKBNetH10HADWZBD4VN258ekbcmpMDIi+Mi1h2A
        Kxm/vbFYnz9YkSiQZRk2Vo0vybN3A1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668073252;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QqANZU+pw5gBuNdePRxF8GAA+MvsR3exid0Kwc/0Xo0=;
        b=aBuPR8nCMneM2ITwXNxurc082i7quPt/l0JvnOMktmWv3sp8xoeh2X+wSc+0v3J/RC69cw
        G7mHUGno8hEOziDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8FC061346E;
        Thu, 10 Nov 2022 09:40:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sJeGIiTHbGN4bAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 10 Nov 2022 09:40:52 +0000
Message-ID: <e3fc40c9-6e4e-d8de-63ce-ce34d78fa883@suse.cz>
Date:   Thu, 10 Nov 2022 10:40:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] tools/vm/slabinfo: indicates the cause of the EACCES
 error
Content-Language: en-US
To:     Rong Tao <rtoax@foxmail.com>, akpm@linux-foundation.org
Cc:     Rong Tao <rongtao@cestc.cn>,
        =?UTF-8?Q?St=c3=a9phane_Graber?= <stgraber@ubuntu.com>,
        Yuanzheng Song <songyuanzheng@huawei.com>,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
References: <tencent_C9D7A6D118445E036021CE2CB4CB4495E207@qq.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <tencent_C9D7A6D118445E036021CE2CB4CB4495E207@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/22 13:47, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> If you don't run slabinfo with a superuser, return 0 when read_slab_dir()
> reads get_obj_and_str("slabs", &t), because fopen() fails (sometimes
> EACCES), causing slabcache() to return directly, without any error during
> this time, we should tell the user about the EACCES problem instead of
> running successfully($?=0) without any error printing.
> 
>  For example:
>  $ ./slabinfo
>  Permission denied, Try using superuser  <== What this submission did
>  $ sudo ./slabinfo
>  Name            Objects Objsize   Space Slabs/Part/Cpu  O/S O %Fr %Ef Flg
>  Acpi-Namespace     5950      48  286.7K         65/0/5   85 0   0  99
>  Acpi-Operand      13664      72  999.4K       231/0/13   56 0   0  98
>  ...
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>

Thanks, added to slab.git slab/for-6.2/tools

> ---
>  tools/vm/slabinfo.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/vm/slabinfo.c b/tools/vm/slabinfo.c
> index 0fffaeedee76..cfaeaea71042 100644
> --- a/tools/vm/slabinfo.c
> +++ b/tools/vm/slabinfo.c
> @@ -157,9 +157,11 @@ static unsigned long read_obj(const char *name)
>  {
>  	FILE *f = fopen(name, "r");
>  
> -	if (!f)
> +	if (!f) {
>  		buffer[0] = 0;
> -	else {
> +		if (errno == EACCES)
> +			fatal("%s, Try using superuser\n", strerror(errno));
> +	} else {
>  		if (!fgets(buffer, sizeof(buffer), f))
>  			buffer[0] = 0;
>  		fclose(f);

