Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BB17274A2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 03:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbjFHB4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 21:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbjFHB4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 21:56:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C8B26B5
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 18:56:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92A8564135
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 01:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE87BC4339B;
        Thu,  8 Jun 2023 01:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686189366;
        bh=zI4G/zMTzBh1j2ootVMCzxAs+++eYjxqqLRG1iq8wdA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=h8a8DXHYT3sWfFLnZgIXZ2pP2pLLSGxSeX2G3jxpottPeMdiNwB4MomwVo3ayrgIM
         cmklzq0VXLqafxX2ZP2LJwzK9vj7QAV1iiCqYw0Uyj/wU7yOm8ePyE8e/7sTw6Zlp3
         OqjiOc78+9Hl3RiwE0vm7yJ8crnKN7Yln4/8KGoxt82/QLLuB7sWblmDe/ef5drzMA
         9EPLIsGEU6aIrUfKd7ElUTRYEydWQwVeJLlnJoCOsR1y5x0JLwx2+WlDwiaclYkb7s
         KwnM6tKMGPqp10aEip16p9qAfjb+CrkwZq/TlL3OsjQXPHMbnsjXkvmZW1JNxh0iIU
         IJx9V+Bwz4iyA==
Message-ID: <1e6878a7-df98-6199-5a9a-c18020b7b739@kernel.org>
Date:   Thu, 8 Jun 2023 09:56:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2] f2fs_io: expend fallocate command
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230607145637.14769-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230607145637.14769-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/7 22:56, Yangtao Li wrote:
> Expend fallocate command to support more flags.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   tools/f2fs_io/f2fs_io.c | 39 +++++++++++++++++++++++++++++++++------
>   1 file changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
> index 1774eca..5a6a6a0 100644
> --- a/tools/f2fs_io/f2fs_io.c
> +++ b/tools/f2fs_io/f2fs_io.c
> @@ -413,9 +413,13 @@ static void do_pinfile(int argc, char **argv, const struct cmd_desc *cmd)
>   
>   #define fallocate_desc "fallocate"
>   #define fallocate_help						\
> -"f2fs_io fallocate [keep_size] [offset] [length] [file]\n\n"	\
> +"f2fs_io fallocate [-cipz] [keep_size] [offset] [length] [file]\n\n"	\

Yangtao,

It missed to update man/f2fs_io.8.

Thanks,

>   "fallocate given the file\n"					\
>   " [keep_size] : 1 or 0\n"					\
> +" -p : punch hole\n"						\
> +" -c : collapse range\n"					\
> +" -z : zero range\n"						\
> +" -i : insert range\n"						\
>   
>   static void do_fallocate(int argc, char **argv, const struct cmd_desc *cmd)
>   {
> @@ -423,20 +427,43 @@ static void do_fallocate(int argc, char **argv, const struct cmd_desc *cmd)
>   	off_t offset, length;
>   	struct stat sb;
>   	int mode = 0;
> +	int c;
>   
> -	if (argc != 5) {
> +	while ((c = getopt(argc, argv, "cipz")) != -1) {
> +		switch (c) {
> +		case 'c':
> +			mode |= FALLOC_FL_COLLAPSE_RANGE;
> +			break;
> +		case 'i':
> +			mode |= FALLOC_FL_INSERT_RANGE;
> +			break;
> +		case 'p':
> +			mode |= FALLOC_FL_PUNCH_HOLE;
> +			break;
> +		case 'z':
> +			mode |= FALLOC_FL_ZERO_RANGE;
> +			break;
> +		default:
> +			fputs(cmd->cmd_help, stderr);
> +			exit(2);
> +		}
> +	}
> +	argc -= optind;
> +	argv += optind;
> +
> +	if (argc != 4) {
>   		fputs("Excess arguments\n\n", stderr);
>   		fputs(cmd->cmd_help, stderr);
>   		exit(1);
>   	}
>   
> -	if (!strcmp(argv[1], "1"))
> +	if (!strcmp(argv[0], "1"))
>   		mode |= FALLOC_FL_KEEP_SIZE;
>   
> -	offset = atoi(argv[2]);
> -	length = atoll(argv[3]);
> +	offset = atoi(argv[1]);
> +	length = atoll(argv[2]);
>   
> -	fd = xopen(argv[4], O_RDWR, 0);
> +	fd = xopen(argv[3], O_RDWR, 0);
>   
>   	if (fallocate(fd, mode, offset, length) != 0)
>   		die_errno("fallocate failed");
