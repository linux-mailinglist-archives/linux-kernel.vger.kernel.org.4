Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58636691D7D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 12:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjBJLCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 06:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbjBJLCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 06:02:12 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745107166E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 03:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1676026926; x=1707562926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AColGikeXYisT7/QbF1eaYTs5Jlq6JncYLcXnr3PDg0=;
  b=c/XpreASluTAqLQfmLm6skkUwLIJJid7D0/IuacOWW9AcaZcEiiTFvEv
   d6rL9cmuhdunuYvC7U65Al/JwyiMJQMEuDiz97nuZZ1cQOee3YoJn6IPh
   /D8AxyV/j2IXfgJvxxDfFkPz4eWaw0GqIAJwa812t7JbL5Bk50363E9jL
   7jn8xMDXent+9lojK4jyiOBfodw0dL6Ud4Oc0bw8mWMpRjtsJe5dn2wFA
   B4xZUoJ/NZ11NzggNKBUyprRrJU0GxwyIj5Wk/z4qHpsrOZId64bcapWi
   nrXAir38+mzlqGX1qaEV45BTz/mFCJU1Fjixni7mqksxOMptZcjXnwBYN
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,286,1669071600"; 
   d="scan'208";a="29002571"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 10 Feb 2023 12:02:02 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 10 Feb 2023 12:02:02 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 10 Feb 2023 12:02:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1676026922; x=1707562922;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AColGikeXYisT7/QbF1eaYTs5Jlq6JncYLcXnr3PDg0=;
  b=bUAuE7FN85KGNUvaih6kZe/opaf82Gb41NdIe2XeQsUqOFZ0snBr13Xc
   1+O7xSzZ3lr3hdM6DT+kUxrBpuEejBK26ETgcsWiWEsFIykk6W0UpIWiZ
   du2MFqit5hxCAgm6lpfTEhFqX4fGAcmGigSSqmPToa9X7LjisjUjMVmeJ
   CHX8+rCwafegP6gqcnQRgOwHivJX221mIvR2SQ4DPALwaAdQei6YSoIU8
   fqgM8tWargfv3nk1ScUia9qnmzcnLvq4ZR0wxOHnHZ1Lp9GQK1vacUfj0
   YYmXAf+nFzc8zgAtbMUgYgHPnvZFzIveSnu8w1Xj/Kq14btV5qtihCHIz
   g==;
X-IronPort-AV: E=Sophos;i="5.97,286,1669071600"; 
   d="scan'208";a="29002569"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 10 Feb 2023 12:02:02 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 4FEB2280056;
        Fri, 10 Feb 2023 12:02:02 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     gregkh@linuxfoundation.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Michael Walle <michael@walle.cc>
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 12/22] nvmem: core: add an index parameter to the cell
Date:   Fri, 10 Feb 2023 12:01:59 +0100
Message-ID: <6214078.lOV4Wx5bFT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230206134356.839737-13-srinivas.kandagatla@linaro.org>
References: <20230206134356.839737-1-srinivas.kandagatla@linaro.org> <20230206134356.839737-13-srinivas.kandagatla@linaro.org>
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

Hi,

Am Montag, 6. Februar 2023, 14:43:46 CET schrieb Srinivas Kandagatla:
> From: Michael Walle <michael@walle.cc>
> 
> Sometimes a cell can represend multiple values. For example, a base
> ethernet address stored in the NVMEM can be expanded into multiple
> discreet ones by adding an offset.
> 
> For this use case, introduce an index parameter which is then used to
> distiguish between values. This parameter will then be passed to the
> post process hook which can then use it to create different values
> during reading.
> 
> At the moment, there is only support for the device tree path. You can
> add the index to the phandle, e.g.
> 
>   &net {
>           nvmem-cells = <&base_mac_address 2>;
>           nvmem-cell-names = "mac-address";
>   };
> 
>   &nvmem_provider {
>           base_mac_address: base-mac-address@0 {
>                   #nvmem-cell-cells = <1>;
>                   reg = <0 6>;
>           };
>   };
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/nvmem/core.c           | 37 ++++++++++++++++++++++++----------
>  drivers/nvmem/imx-ocotp.c      |  4 ++--
>  include/linux/nvmem-provider.h |  4 ++--
>  3 files changed, 30 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 233c6c275031..30567dd51fba 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -60,6 +60,7 @@ struct nvmem_cell_entry {
>  struct nvmem_cell {
>  	struct nvmem_cell_entry *entry;
>  	const char		*id;
> +	int			index;
>  };
> 
>  static DEFINE_MUTEX(nvmem_mutex);
> @@ -1122,7 +1123,8 @@ struct nvmem_device *devm_nvmem_device_get(struct
> device *dev, const char *id) }
>  EXPORT_SYMBOL_GPL(devm_nvmem_device_get);
> 
> -static struct nvmem_cell *nvmem_create_cell(struct nvmem_cell_entry *entry,
> const char *id) +static struct nvmem_cell *nvmem_create_cell(struct
> nvmem_cell_entry *entry, +					    
const char *id, int index)
>  {
>  	struct nvmem_cell *cell;
>  	const char *name = NULL;
> @@ -1141,6 +1143,7 @@ static struct nvmem_cell *nvmem_create_cell(struct
> nvmem_cell_entry *entry, cons
> 
>  	cell->id = name;
>  	cell->entry = entry;
> +	cell->index = index;
> 
>  	return cell;
>  }
> @@ -1179,7 +1182,7 @@ nvmem_cell_get_from_lookup(struct device *dev, const
> char *con_id) __nvmem_device_put(nvmem);
>  				cell = ERR_PTR(-ENOENT);
>  			} else {
> -				cell = nvmem_create_cell(cell_entry, 
con_id);
> +				cell = nvmem_create_cell(cell_entry, 
con_id, 0);
>  				if (IS_ERR(cell))
>  					__nvmem_device_put(nvmem);
>  			}
> @@ -1227,15 +1230,27 @@ struct nvmem_cell *of_nvmem_cell_get(struct
> device_node *np, const char *id) struct nvmem_device *nvmem;
>  	struct nvmem_cell_entry *cell_entry;
>  	struct nvmem_cell *cell;
> +	struct of_phandle_args cell_spec;
>  	int index = 0;
> +	int cell_index = 0;
> +	int ret;
> 
>  	/* if cell name exists, find index to the name */
>  	if (id)
>  		index = of_property_match_string(np, "nvmem-cell-names", 
id);
> 
> -	cell_np = of_parse_phandle(np, "nvmem-cells", index);
> -	if (!cell_np)
> -		return ERR_PTR(-ENOENT);
> +	ret = of_parse_phandle_with_optional_args(np, "nvmem-cells",
> +						  "#nvmem-cell-
cells",
> +						  index, 
&cell_spec);
> +	if (ret)
> +		return ERR_PTR(ret);

This change introduce a regression (again, see [1] for that). 
dp83867_of_init_io_impedance calls of_nvmem_cell_get() for cell 
'io_impedance_ctrl'. If this does not exist, 'nvmem-cell-names' does not exist 
as well,  of_property_match_string returns -22 for index. 
__of_parse_phandle_with_args eventually returns -EINVAL for this invalid 
index. -ENOENT was returned before.
There was a bugfix [2] for this, but it's not in linux-next.

Best regards,
Alexander

[1] https://lore.kernel.org/lkml/2143916.GUh0CODmnK@steina-w/
[2] https://lore.kernel.org/lkml/20230105135931.2743351-1-michael@walle.cc/T/
> +
> +	if (cell_spec.args_count > 1)
> +		return ERR_PTR(-EINVAL);
> +
> +	cell_np = cell_spec.np;
> +	if (cell_spec.args_count)
> +		cell_index = cell_spec.args[0];
> 
>  	nvmem_np = of_get_parent(cell_np);
>  	if (!nvmem_np) {
> @@ -1257,7 +1272,7 @@ struct nvmem_cell *of_nvmem_cell_get(struct
> device_node *np, const char *id) return ERR_PTR(-ENOENT);
>  	}
> 
> -	cell = nvmem_create_cell(cell_entry, id);
> +	cell = nvmem_create_cell(cell_entry, id, cell_index);
>  	if (IS_ERR(cell))
>  		__nvmem_device_put(nvmem);
> 
> @@ -1410,8 +1425,8 @@ static void nvmem_shift_read_buffer_in_place(struct
> nvmem_cell_entry *cell, void }
> 
>  static int __nvmem_cell_read(struct nvmem_device *nvmem,
> -		      struct nvmem_cell_entry *cell,
> -		      void *buf, size_t *len, const char *id)
> +			     struct nvmem_cell_entry *cell,
> +			     void *buf, size_t *len, const char *id, int 
index)
>  {
>  	int rc;
> 
> @@ -1425,7 +1440,7 @@ static int __nvmem_cell_read(struct nvmem_device
> *nvmem, nvmem_shift_read_buffer_in_place(cell, buf);
> 
>  	if (nvmem->cell_post_process) {
> -		rc = nvmem->cell_post_process(nvmem->priv, id,
> +		rc = nvmem->cell_post_process(nvmem->priv, id, index,
>  					      cell->offset, buf, 
cell->bytes);
>  		if (rc)
>  			return rc;
> @@ -1460,7 +1475,7 @@ void *nvmem_cell_read(struct nvmem_cell *cell, size_t
> *len) if (!buf)
>  		return ERR_PTR(-ENOMEM);
> 
> -	rc = __nvmem_cell_read(nvmem, cell->entry, buf, len, cell->id);
> +	rc = __nvmem_cell_read(nvmem, cell->entry, buf, len, cell->id,
> cell->index); if (rc) {
>  		kfree(buf);
>  		return ERR_PTR(rc);
> @@ -1773,7 +1788,7 @@ ssize_t nvmem_device_cell_read(struct nvmem_device
> *nvmem, if (rc)
>  		return rc;
> 
> -	rc = __nvmem_cell_read(nvmem, &cell, buf, &len, NULL);
> +	rc = __nvmem_cell_read(nvmem, &cell, buf, &len, NULL, 0);
>  	if (rc)
>  		return rc;
> 
> diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
> index 14284e866f26..e9b52ecb3f72 100644
> --- a/drivers/nvmem/imx-ocotp.c
> +++ b/drivers/nvmem/imx-ocotp.c
> @@ -222,8 +222,8 @@ static int imx_ocotp_read(void *context, unsigned int
> offset, return ret;
>  }
> 
> -static int imx_ocotp_cell_pp(void *context, const char *id, unsigned int
> offset, -			     void *data, size_t bytes)
> +static int imx_ocotp_cell_pp(void *context, const char *id, int index,
> +			     unsigned int offset, void *data, size_t 
bytes)
>  {
>  	struct ocotp_priv *priv = context;
> 
> diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
> index bb15c9234e21..55181d837969 100644
> --- a/include/linux/nvmem-provider.h
> +++ b/include/linux/nvmem-provider.h
> @@ -20,8 +20,8 @@ typedef int (*nvmem_reg_read_t)(void *priv, unsigned int
> offset, typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
> void *val, size_t bytes);
>  /* used for vendor specific post processing of cell data */
> -typedef int (*nvmem_cell_post_process_t)(void *priv, const char *id,
> unsigned int offset, -					  void 
*buf, size_t bytes);
> +typedef int (*nvmem_cell_post_process_t)(void *priv, const char *id, int
> index, +					 unsigned int offset, void 
*buf, size_t bytes);
> 
>  enum nvmem_type {
>  	NVMEM_TYPE_UNKNOWN = 0,




