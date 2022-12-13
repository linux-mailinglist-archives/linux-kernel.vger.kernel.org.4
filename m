Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF9164B036
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 08:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbiLMHLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 02:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbiLMHLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 02:11:06 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D673129
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 23:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OtUnH8puMoigAwnSYIolqkRd6u4feH/uNXVMZiHt9uQ=; b=XoiqYhncV4I3m31iL7plQmDCx3
        HRJuT65Chgb7HFFH1dpfnRiUeV67PHNZ8VKF1GqSk3/OqsZTQet1c2A/GWfopxm4yxteoeOMnzSG6
        cP25trUIAwmQ7fUAF0zvErgXIlLVyVGD79uBy1Oy8TVQMUBhFIwh80ryB0suLlN2iPULbiM1HMqw5
        MHp5MAq1GBMjFYN4oLWACBmE1gUcBzhPL67SytL11p3kXFJ5RetE6rbPH4/+xNhmpxxrypx3uAUlg
        DnhftcZykZVB5XrQPg3zxra4dbs3GB9HPiUTCkykDT1ZXaKPuW/88lnaQx0T49UtvfcOnD0IbGT6r
        awBXhMDw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1p4zRK-00BYAu-2L;
        Tue, 13 Dec 2022 07:10:58 +0000
Date:   Tue, 13 Dec 2022 07:10:58 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Evgeniy Dushistov <dushistov@mail.ru>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] fs/ufs: Change the signature of ufs_get_page()
Message-ID: <Y5glgpD7fFifC4Fi@ZenIV>
References: <bpf@vger.kernel.org,linux-fsdevel@vger.kernel.org>
 <20221212231906.19424-1-fmdefrancesco@gmail.com>
 <20221212231906.19424-3-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212231906.19424-3-fmdefrancesco@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 12:19:05AM +0100, Fabio M. De Francesco wrote:
> +static void *ufs_get_page(struct inode *dir, unsigned long n, struct page **page)
>  {
>  	struct address_space *mapping = dir->i_mapping;
> -	struct page *page = read_mapping_page(mapping, n, NULL);
> -	if (!IS_ERR(page)) {
> -		kmap(page);
> -		if (unlikely(!PageChecked(page))) {
> -			if (!ufs_check_page(page))
> +	*page = read_mapping_page(mapping, n, NULL);
> +	if (!IS_ERR(*page)) {
> +		kmap(*page);
> +		if (unlikely(!PageChecked(*page))) {
> +			if (!ufs_check_page(*page))
>  				goto fail;
>  		}
>  	}
> -	return page;
> +	return page_address(*page);

Er...   You really don't want to do that when you've got ERR_PTR()
from read_mapping_page().
>  
>  fail:
> -	ufs_put_page(page);
> +	ufs_put_page(*page);
>  	return ERR_PTR(-EIO);
>  }

IDGI...

static void *ufs_get_page(struct inode *dir, unsigned long n, struct page **p)
{
	struct address_space *mapping = dir->i_mapping;
	struct page *page = read_mapping_page(mapping, n, NULL);

	if (!IS_ERR(page)) {
		kmap(page);
		if (unlikely(!PageChecked(page))) {
			if (!ufs_check_page(page))
				goto fail;
		}
		*p = page;
		return page_address(page);
	}
	return ERR_CAST(page);

fail:
	ufs_put_page(page);
	return ERR_PTR(-EIO);
}

all there is to it...  The only things you need to change are
1) type of function
2) make sure to store the page into that pointer to pointer to page on success
3) return page_address(page) instead of page on success
4) use ERR_CAST() to convert ERR_PTR() that is struct page * into equal
ERR_PTR() that is void * (the last one is optional, just makes the intent
more clear).
