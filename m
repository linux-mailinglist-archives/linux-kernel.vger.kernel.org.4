Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D03A633D32
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbiKVNL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbiKVNLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:11:18 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D335963B85;
        Tue, 22 Nov 2022 05:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669122674; x=1700658674;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uDAbUmrJSxyGSM1AaF/SoNBLvIhsZuamrriTLiE8KOs=;
  b=MuWiMaLSBJptCHxPKR2RleH0+dp0ctnOENLyrUGewAUYzC4MvCSAceXl
   G3YQyufJBsaBmUYdEfUf/k9FIvJ7lXnC6onHjAmM/QV186lmwt4YeQRny
   J7/2Z3i25bic5sGwMB0D8V4npIkxcRFlCXOV5/k1afUAppfmOV5c1L0+k
   a+ySr2z6HUZBaFuWlXXDd7Af7wBIF1d+pFdbcOLlmfGSGFmkkXhy/d9p5
   qJpxlxTJOtyEqyBW1iwJ4R449n3AAvQgixvHcxM16+a5Y4F7A0QSHw83C
   VbxJZchRMlUiAcvTFDcpaFSexmfzomrO2cfQF1Jf83v6C8Ud8X46VW1Lu
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="293519263"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="293519263"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 05:11:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="783834220"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="783834220"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 22 Nov 2022 05:11:10 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 22 Nov 2022 15:11:09 +0200
Date:   Tue, 22 Nov 2022 15:11:09 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v3 1/3] device property: Get rid of
 __PROPERTY_ENTRY_ARRAY_EL*SIZE*()
Message-ID: <Y3zKbbMpcaHfqB2C@kuha.fi.intel.com>
References: <20221111154621.15941-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111154621.15941-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 05:46:19PM +0200, Andy Shevchenko wrote:
> First of all, _ELEMENT_SIZE() repeats existing sizeof_field() macro.
> Second, usage of _ARRAY_ELSIZE_LEN() adds unnecessary indirection
> to the data layout. It's more understandable when the data structure
> is placed explicitly. That said, get rid of those macros by replacing
> them with the existing helper and explicit data structure layout.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

For the series:

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> v3: fixed typo in PROPERTY_ENTRY_REF_ARRAY_LEN() impl (LKP)
> v2: rebased on latest Linux Next, fixed anon union assignment
>  include/linux/property.h | 34 ++++++++++++++--------------------
>  1 file changed, 14 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 5d840299146d..0eab13a5c7df 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -12,6 +12,7 @@
>  
>  #include <linux/bits.h>
>  #include <linux/fwnode.h>
> +#include <linux/stddef.h>
>  #include <linux/types.h>
>  
>  struct device;
> @@ -311,24 +312,14 @@ struct property_entry {
>   * crafted to avoid gcc-4.4.4's problems with initialization of anon unions
>   * and structs.
>   */
> -
> -#define __PROPERTY_ENTRY_ELEMENT_SIZE(_elem_)				\
> -	sizeof(((struct property_entry *)NULL)->value._elem_[0])
> -
> -#define __PROPERTY_ENTRY_ARRAY_ELSIZE_LEN(_name_, _elsize_, _Type_,	\
> -					  _val_, _len_)			\
> -(struct property_entry) {						\
> -	.name = _name_,							\
> -	.length = (_len_) * (_elsize_),					\
> -	.type = DEV_PROP_##_Type_,					\
> -	{ .pointer = _val_ },						\
> +#define __PROPERTY_ENTRY_ARRAY_LEN(_name_, _elem_, _Type_, _val_, _len_)		\
> +(struct property_entry) {								\
> +	.name = _name_,									\
> +	.length = (_len_) * sizeof_field(struct property_entry, value._elem_[0]),	\
> +	.type = DEV_PROP_##_Type_,							\
> +	{ .pointer = _val_ },								\
>  }
>  
> -#define __PROPERTY_ENTRY_ARRAY_LEN(_name_, _elem_, _Type_, _val_, _len_)\
> -	__PROPERTY_ENTRY_ARRAY_ELSIZE_LEN(_name_,			\
> -				__PROPERTY_ENTRY_ELEMENT_SIZE(_elem_),	\
> -				_Type_, _val_, _len_)
> -
>  #define PROPERTY_ENTRY_U8_ARRAY_LEN(_name_, _val_, _len_)		\
>  	__PROPERTY_ENTRY_ARRAY_LEN(_name_, u8_data, U8, _val_, _len_)
>  #define PROPERTY_ENTRY_U16_ARRAY_LEN(_name_, _val_, _len_)		\
> @@ -340,9 +331,12 @@ struct property_entry {
>  #define PROPERTY_ENTRY_STRING_ARRAY_LEN(_name_, _val_, _len_)		\
>  	__PROPERTY_ENTRY_ARRAY_LEN(_name_, str, STRING, _val_, _len_)
>  #define PROPERTY_ENTRY_REF_ARRAY_LEN(_name_, _val_, _len_)		\
> -	__PROPERTY_ENTRY_ARRAY_ELSIZE_LEN(_name_,			\
> -				sizeof(struct software_node_ref_args),	\
> -				REF, _val_, _len_)
> +(struct property_entry) {						\
> +	.name = _name_,							\
> +	.length = (_len_) * sizeof(struct software_node_ref_args),	\
> +	.type = DEV_PROP_REF,						\
> +	{ .pointer = _val_ },						\
> +}
>  
>  #define PROPERTY_ENTRY_U8_ARRAY(_name_, _val_)				\
>  	PROPERTY_ENTRY_U8_ARRAY_LEN(_name_, _val_, ARRAY_SIZE(_val_))
> @@ -360,7 +354,7 @@ struct property_entry {
>  #define __PROPERTY_ENTRY_ELEMENT(_name_, _elem_, _Type_, _val_)		\
>  (struct property_entry) {						\
>  	.name = _name_,							\
> -	.length = __PROPERTY_ENTRY_ELEMENT_SIZE(_elem_),		\
> +	.length = sizeof_field(struct property_entry, value._elem_[0]),	\
>  	.is_inline = true,						\
>  	.type = DEV_PROP_##_Type_,					\
>  	{ .value = { ._elem_[0] = _val_ } },				\
> -- 
> 2.35.1

-- 
heikki
