Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D9D6DD0A1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 06:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjDKEBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 00:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjDKEBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 00:01:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9AB98
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 21:01:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F26561A73
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:01:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E362C433D2;
        Tue, 11 Apr 2023 04:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1681185702;
        bh=HFcCfjMjSwhvTHBboit2JX2IkmCKUJk3G1R9ZYyYF1Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k/rSfN0GUVuVoGdVi+y0qknccHGcl5/uRhakWeMGLzxHuuJrVKBl4H+12PvnixjoV
         y70O8tO/qrMg4yY/KL9/LF5GAiqyKLMA50xPaXdd6twR1M8iCFykrL0TdSoQA1jMVC
         4TAni3xfw+Ex77aN2ehWjfE63bTnlKgqAkav2IAo=
Date:   Mon, 10 Apr 2023 21:01:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Steve Chou <steve_chou@pesi.com.tw>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jiajian Ye <yejiajian2018@email.szu.edu.cn>
Subject: Re: [PATCH] tools/mm/page_owner_sort.c: fix TGID output when
 cull=tg is used
Message-Id: <20230410210141.678bf917bfce759caf9d18df@linux-foundation.org>
In-Reply-To: <20230411034929.2071501-1-steve_chou@pesi.com.tw>
References: <20230411034929.2071501-1-steve_chou@pesi.com.tw>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023 11:49:28 +0800 Steve Chou <steve_chou@pesi.com.tw> wrote:

> When using cull option with 'tg' flag, the fprintf is using pid instead
> of tgid. It should use tgid instead.
> 
> ...
>
> --- a/tools/mm/page_owner_sort.c
> +++ b/tools/mm/page_owner_sort.c
> @@ -857,7 +857,7 @@ int main(int argc, char **argv)
>  			if (cull & CULL_PID || filter & FILTER_PID)
>  				fprintf(fout, ", PID %d", list[i].pid);
>  			if (cull & CULL_TGID || filter & FILTER_TGID)
> -				fprintf(fout, ", TGID %d", list[i].pid);
> +				fprintf(fout, ", TGID %d", list[i].tgid);
>  			if (cull & CULL_COMM || filter & FILTER_COMM)
>  				fprintf(fout, ", task_comm_name: %s", list[i].comm);
>  			if (cull & CULL_ALLOCATOR) {

Thanks, copy-paste error, I expect.  I'll add Fixes: 9c8a0a8e599
("tools/vm/page_owner_sort.c: support for user-defined culling rules")
and cc:stable.

