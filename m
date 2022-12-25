Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F184655CDB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 11:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbiLYKgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 05:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLYKgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 05:36:12 -0500
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD1F333
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 02:36:10 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id a17so8120956wrt.11
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 02:36:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EchhkTTeWj/l3b3OSWkA05dF2p08TbkhmMoG0JUIzmI=;
        b=3MKclYL8+T2N34KGlnOq+rOKBd2v0XXc0PGk/0EqoyQGxU2LcPSfDRo0KaHDDnSUqk
         uvYgKn/Vhkyh4aMUXPp4hg0sLARAKvoiECD70O4VGqpU5SaplvbwdZVEiuj5SMGHco5f
         soZ5XZjRyLgrivNn4tet61B1eqvxsnMvNBjXrNKsWfaFBv7lgU/Tuk791d1salM793vO
         8GBh6RByTgc3LXW6t8AjiVW9RvYgedyRBmi9bqKVDWiXvHH3/wEA/lYnQXXqUy6U3zyQ
         sKmDkkTCsMG0ZIehcdVJxBZlYGueSQ9/nMEBf3x+hYqNZKbIE0sAmPCV6cBXDWpWQ1dr
         30Nw==
X-Gm-Message-State: AFqh2ko+Ufdvk/Js/A2mEsvbaL3U3+dHUKTWhuwobVSk+gtqVWt6S1GX
        urPg8zEqbHW8nq+kqAYxLcY=
X-Google-Smtp-Source: AMrXdXsZq0rGK2qT91H/thFx92Zy0/jrCMOZJYqtAFXAt1xuzx3RGwe+7pwKbhV7MjxXHLdnch9mYg==
X-Received: by 2002:a5d:4008:0:b0:242:17d3:a9fc with SMTP id n8-20020a5d4008000000b0024217d3a9fcmr9668380wrp.30.1671964569227;
        Sun, 25 Dec 2022 02:36:09 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id b2-20020adff242000000b0023662245d3csm7619890wrp.95.2022.12.25.02.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Dec 2022 02:36:08 -0800 (PST)
Message-ID: <594b768a-9311-da86-1619-5435d3f720f5@grimberg.me>
Date:   Sun, 25 Dec 2022 12:36:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: drivers/nvme/host/auth.c:950 nvme_auth_init_ctrl() warn: missing
 error code? 'ret'
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Dan Carpenter <error27@gmail.com>
Cc:     oe-kbuild@lists.linux.dev, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
References: <202212222333.vrYfUBqM-lkp@intel.com>
 <20221223154754.GA30339@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221223154754.GA30339@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/23/22 17:47, Christoph Hellwig wrote:
> Based on the code in nvme_auth_generate_key I assume this is intentional,
> but the code looks really confusing.
> 
> Hannes, Sagi, what do you think of something like this:
> 
> 
> diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
> index d90e4f0c08b7b9..a07eb4cd9ce173 100644
> --- a/drivers/nvme/common/auth.c
> +++ b/drivers/nvme/common/auth.c
> @@ -455,28 +455,18 @@ int nvme_auth_gen_shared_secret(struct crypto_kpp *dh_tfm,
>   }
>   EXPORT_SYMBOL_GPL(nvme_auth_gen_shared_secret);
>   
> -int nvme_auth_generate_key(u8 *secret, struct nvme_dhchap_key **ret_key)
> +struct nvme_dhchap_key *nvme_auth_generate_key(u8 *secret)
>   {
> -	struct nvme_dhchap_key *key;
>   	u8 key_hash;
>   
> -	if (!secret) {
> -		*ret_key = NULL;
> -		return 0;
> -	}
> +	if (!secret)
> +		return NULL;
>   
>   	if (sscanf(secret, "DHHC-1:%hhd:%*s:", &key_hash) != 1)
> -		return -EINVAL;
> +		return ERR_PTR(-EINVAL);
>   
>   	/* Pass in the secret without the 'DHHC-1:XX:' prefix */
> -	key = nvme_auth_extract_key(secret + 10, key_hash);
> -	if (IS_ERR(key)) {
> -		*ret_key = NULL;
> -		return PTR_ERR(key);
> -	}
> -
> -	*ret_key = key;
> -	return 0;
> +	return nvme_auth_extract_key(secret + 10, key_hash);
>   }
>   EXPORT_SYMBOL_GPL(nvme_auth_generate_key);
>   
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index bb0abbe4491cdc..c808652966a94f 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -943,16 +943,19 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
>   	INIT_WORK(&ctrl->dhchap_auth_work, nvme_ctrl_auth_work);
>   	if (!ctrl->opts)
>   		return 0;
> -	ret = nvme_auth_generate_key(ctrl->opts->dhchap_secret,
> -			&ctrl->host_key);
> -	if (ret)
> -		return ret;
> -	ret = nvme_auth_generate_key(ctrl->opts->dhchap_ctrl_secret,
> -			&ctrl->ctrl_key);
> -	if (ret)
> +
> +	ctrl->host_key = nvme_auth_generate_key(ctrl->opts->dhchap_secret);
> +	if (IS_ERR(ctrl->host_key)) {

nvme_auth_generate_key can return NULL, so in this case we should avoid
calling it if the secret is null here.

Other than that, this looks good.
Although I think that for this specific report, we should do a simple
fix and then make the code look better.
