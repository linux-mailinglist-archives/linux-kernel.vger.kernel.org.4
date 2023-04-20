Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52436E9D68
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 22:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjDTUqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 16:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjDTUqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 16:46:03 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C035359F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 13:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X3b9GsUwpYKeLaZJwp+ULnsmb0Ew2c/ag5wOzD9xBGg=; b=Wo4KnFsSV8NVDRCCzIgaO+7YMZ
        TGeVoZzbcIPCV4AudQ4WRzuGLJrfTiIHzkzxV6h2qeIc9DXLjd2avvvY4f2AfYZWzNuID0Mro9Snx
        lehRE3YZAqgwn4PtI+lmt73C+AcDqau6nBiPNVnUgx7T4WNcQOsPtbv4uQ32rjTA0y03QifZGTp5i
        QjoSq+/k6YQOXCdbYyiEcxWI/Ddr1sGn1VTwucrRmNgBfnUXCFbm79fQBZn+LlPpNRm7rY9RvJdfE
        b8fZXpM+SX+sj60tYm69TW8ltqbcKRcrHKU65FAVRCCmnYqMzc0GRQ3QNuOMfFjijuX7eme9kdUYx
        7+/2oQ3g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ppbA1-00AxLY-1t;
        Thu, 20 Apr 2023 20:45:45 +0000
Date:   Thu, 20 Apr 2023 21:45:45 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     mszeredi@redhat.com, bigeasy@linutronix.de, mcgrof@kernel.org,
        xiubli@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] vfs: clean up d_backing_inode() function
Message-ID: <20230420204545.GN3390869@ZenIV>
References: <CAOssrKfCiByavRNekRUOCv==AEvWAO6B6=tAASyYdvWj9XRhBw@mail.gmail.com>
 <20230419104704.243950-1-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419104704.243950-1-haifeng.xu@shopee.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 10:47:04AM +0000, Haifeng Xu wrote:
> d_backing_inode() does the same thing with d_inode(), so using
> d_inode() to get the inode of dentry instead of d_backing_inode().
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> Suggested-by: Miklos Szeredi <mszeredi@redhat.com>

Fine by me, but generally that kind of search-and-replace is
better done differently:

1) patch replacing the definition of d_backing_inode() with
#define d_backing_inode d_inode

2) mail to Linus, asking to do mechanical search-and-replace
just prior to -rc1; see e.g. 7c0f6ba682b9 for example of
that being done.  In this case the script would be
sed -i -e "s/\<d_backing_inode\>/d_inode/g" $(git grep -l -w "d_backing_inode")
sed -i -e "/#define d_inode d_inode/d" include/linux/dentry.h
