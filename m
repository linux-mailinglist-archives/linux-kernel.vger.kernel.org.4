Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C2D65EEA1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 15:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbjAEOVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 09:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjAEOU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 09:20:59 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77698313
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 06:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1672928457; x=1704464457;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5NSOtoeMbNg7K9lSDnR+3y2JY7MECEcqj20jo+eSw7k=;
  b=H7U8yGQ+7lzB/4ayW/GQ9cqHx8UXuEYnafdza/0Epy7eLkx3LJCh0/4W
   oGP/vkOBVjp2Psb3zxY1DbeGDLUM8y8HN/RI+rusYyw2zUr0y8nbAFK0I
   WkKu1stXA020Exks7Q5jKkUOvZBUUMxeF6zln+z50adaPargRA6uvpboX
   AH50/llDHPJwwcwYlEdwmFU8EVq22sPt9rjF4uf0UAIrgu5cC1Eow/P3F
   kgVKAmARpMaiSIlvHnzJnPq1KJIrAkc14gSHQQOUaxqgyZKgA67P3AA4m
   62iP5oLDBs2Ycq6uWlkl2sdIrSLyKYivNgBKzKhXXkQhD/FpyX0iv++Yy
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,303,1665439200"; 
   d="scan'208";a="28261937"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 05 Jan 2023 15:20:55 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 05 Jan 2023 15:20:55 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 05 Jan 2023 15:20:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1672928455; x=1704464455;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5NSOtoeMbNg7K9lSDnR+3y2JY7MECEcqj20jo+eSw7k=;
  b=mlikXSKuHyTwyxv2JRpkP5Gx++ghPNvohSG4XxMs1dcYIJ8O0K/paU9t
   XbLVqBAforSNlFQLqAGMOe5zZ86Z5OaRaLojihGQ4l2yhXgZAOkX4USoO
   a8XbMkjWoMsEGyJfFxAFm4bYjBZK2LzZIER4O/AT6eUkkA/7YLkbkmm59
   5l/paPAL40FxSReBAa8aCxQHyZdhL5dRAvxqL+68DZxgsREA+IVV8HljM
   HF0FQolZ0m/7XU4KNVGzagP2EX0fj9t1oUgvTBy5CMGyLnkfmOUivoaLK
   kTuLLG1A9P70IJUCzgsXM6UQrmLRScO10MjDt6u9VteMsKrKTWoAARNuK
   g==;
X-IronPort-AV: E=Sophos;i="5.96,303,1665439200"; 
   d="scan'208";a="28261936"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 05 Jan 2023 15:20:55 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 9C15A280056;
        Thu,  5 Jan 2023 15:20:55 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Michael Walle <michael@walle.cc>
Cc:     Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH] nvmem: core: return -ENOENT if nvmem cell is not found
Date:   Thu, 05 Jan 2023 15:20:53 +0100
Message-ID: <1888904.g5d078U9FE@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230105135931.2743351-1-michael@walle.cc>
References: <20230105135931.2743351-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 5. Januar 2023, 14:59:31 CET schrieb Michael Walle:
> Prior to commit 3cb05fdbaed6 ("nvmem: core: add an index parameter to
> the cell") of_nvmem_cell_get() would return -ENOENT if the cell wasn't
> found. Particularly, if of_property_match_string() returned -EINVAL,
> that return code was passed as the index to of_parse_phandle(), which
> then detected it as invalid and returned NULL. That led to an return
> code of -ENOENT.
> 
> With the new code, the negative index will lead to an -EINVAL of
> of_parse_phandle_with_optional_args() which pass straight to the
> caller and break those who expect an -ENOENT.
> 
> Fix it by always returning -ENOENT.
> 
> Fixes: 3cb05fdbaed6 ("nvmem: core: add an index parameter to the cell")
> Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> 
> Alexander, could you give this another try? I've changed it slightly,
> so it's a better match with how the handling was before.
> 
> 
>  drivers/nvmem/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 1b61c8bf0de4..cc885b602690 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -1343,7 +1343,7 @@ struct nvmem_cell *of_nvmem_cell_get(struct
> device_node *np, const char *id) "#nvmem-cell-cells",
>  						  index, 
&cell_spec);
>  	if (ret)
> -		return ERR_PTR(ret);
> +		return ERR_PTR(-ENOENT);
> 
>  	if (cell_spec.args_count > 1)
>  		return ERR_PTR(-EINVAL);

Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>



