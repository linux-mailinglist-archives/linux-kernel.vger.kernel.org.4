Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C0C73999C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjFVI1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjFVI1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:27:41 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760E52105
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:27:18 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fa71db4208so4351035e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687422432; x=1690014432;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DJYHqw3D4Te2NgT7iaCLgVm9j4LM7F8hPpOSxaRVdzk=;
        b=gP7EEAqA3xQjNJh7NhbxNgWTi6UzkZZJS5QUpJ6aKk0FpdwF6kBS/fusTOd3MJfaxZ
         dE3C1gXGr0twsIU2NofYqTmAwsxUwJTtG832EAqv0oMXbD6VjFgwckcm+ULKQWZmzyVU
         k2/IKx0n0uKp+g7/xR2HkYpulO8w1cYjRh5BrwxErAq1CORv33lq/Cko4kctDD2SzgAH
         RgjVkWLBkyZOtIysN52AKCFBcnFcGoluEpckYeb6ucbfX8vBHdLN5mRfSeXvrs5ycGX7
         oxIATVz8AOL3GAfpqQHq1zezkdyxqwElU4wq9p2trNOQvyDF8yvmlwLRpk2yWe11G45s
         n6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687422432; x=1690014432;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DJYHqw3D4Te2NgT7iaCLgVm9j4LM7F8hPpOSxaRVdzk=;
        b=fGUPmKJ3+12StrvnJJGeAoDbbfYqiEisUUyaA+9VCH1DGxy9dI7ml8Xm26xRgYuarf
         3eN+0Jo380tLYYEAVtBmKzT6IR0i9CApLlhAoPA5OH1fzy8zkcHSfHmtLeL50+AS6OXs
         CrsMrdJ4CtTc7WWwF5dOcEWVS45GxYm5adZOfOV12fH2j0QTyfLDQGz1UMlJ+id4e/90
         jrAcAagrFaZj46VcwLC//feD6v9Ted7Kzk9tnJsl3fs0/hWidAxhlBw+72gK8fhw41QZ
         9AsbkARlCVkMfRAB2CwEi3T2eaFO2kp7rxX5cZarPYLCkvXgcLttTG3O0pMS7+cXKNGx
         lblg==
X-Gm-Message-State: AC+VfDyXRT1V8xLrI5GMgnLAl4gC2Pzfu2ufZL5N1NKWm9Nxeumu52oj
        JLrGkOjzaJpmtYcrMJKcA+6CJA==
X-Google-Smtp-Source: ACHHUZ5uClDGzi1K5FLFcx1TiwjyJvCJ4iEBx+lJqD0eiXBTyOn+Jsh6bSQQbmq+4a635ehxy5+xSw==
X-Received: by 2002:a7b:cd14:0:b0:3f9:b445:903b with SMTP id f20-20020a7bcd14000000b003f9b445903bmr6373733wmj.9.1687422432051;
        Thu, 22 Jun 2023 01:27:12 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e22-20020a05600c219600b003f8fb02c413sm7056261wme.8.2023.06.22.01.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:27:09 -0700 (PDT)
Date:   Thu, 22 Jun 2023 11:27:05 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Steve French <stfrench@microsoft.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: fs/smb/client/smb2ops.c:2029 smb3_enum_snapshots() warn: variable
 dereferenced before check 'ioc_buf' (see line 2003)
Message-ID: <23b29243-66ba-4796-935a-39c7fff79027@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dad9774deaf1cf8e8f7483310dfb2690310193d2
commit: 38c8a9a52082579090e34c033d439ed2cd1a462d smb: move client and server files to common directory fs/smb
config: m68k-randconfig-m031-20230622 (https://download.01.org/0day-ci/archive/20230622/202306221539.2zBvWDuV-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230622/202306221539.2zBvWDuV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202306221539.2zBvWDuV-lkp@intel.com/

smatch warnings:
fs/smb/client/smb2ops.c:2029 smb3_enum_snapshots() warn: variable dereferenced before check 'ioc_buf' (see line 2003)
fs/smb/client/dfs_cache.c:403 copy_ref_data() warn: passing a valid pointer to 'PTR_ERR'

vim +/ioc_buf +2029 fs/smb/client/smb2ops.c

834170c85978b0 fs/cifs/smb2ops.c Steve French 2016-09-30  1985  static int
834170c85978b0 fs/cifs/smb2ops.c Steve French 2016-09-30  1986  smb3_enum_snapshots(const unsigned int xid, struct cifs_tcon *tcon,
834170c85978b0 fs/cifs/smb2ops.c Steve French 2016-09-30  1987  		   struct cifsFileInfo *cfile, void __user *ioc_buf)
834170c85978b0 fs/cifs/smb2ops.c Steve French 2016-09-30  1988  {
834170c85978b0 fs/cifs/smb2ops.c Steve French 2016-09-30  1989  	char *retbuf = NULL;
834170c85978b0 fs/cifs/smb2ops.c Steve French 2016-09-30  1990  	unsigned int ret_data_len = 0;
834170c85978b0 fs/cifs/smb2ops.c Steve French 2016-09-30  1991  	int rc;
153322f7536a18 fs/cifs/smb2ops.c Steve French 2019-03-28  1992  	u32 max_response_size;
834170c85978b0 fs/cifs/smb2ops.c Steve French 2016-09-30  1993  	struct smb_snapshot_array snapshot_in;
834170c85978b0 fs/cifs/smb2ops.c Steve French 2016-09-30  1994  
973189aba69e59 fs/cifs/smb2ops.c Steve French 2019-04-04  1995  	/*
973189aba69e59 fs/cifs/smb2ops.c Steve French 2019-04-04  1996  	 * On the first query to enumerate the list of snapshots available
973189aba69e59 fs/cifs/smb2ops.c Steve French 2019-04-04  1997  	 * for this volume the buffer begins with 0 (number of snapshots
973189aba69e59 fs/cifs/smb2ops.c Steve French 2019-04-04  1998  	 * which can be returned is zero since at that point we do not know
973189aba69e59 fs/cifs/smb2ops.c Steve French 2019-04-04  1999  	 * how big the buffer needs to be). On the second query,
973189aba69e59 fs/cifs/smb2ops.c Steve French 2019-04-04  2000  	 * it (ret_data_len) is set to number of snapshots so we can
973189aba69e59 fs/cifs/smb2ops.c Steve French 2019-04-04  2001  	 * know to set the maximum response size larger (see below).
973189aba69e59 fs/cifs/smb2ops.c Steve French 2019-04-04  2002  	 */
153322f7536a18 fs/cifs/smb2ops.c Steve French 2019-03-28 @2003  	if (get_user(ret_data_len, (unsigned int __user *)ioc_buf))

If ioc_buf is NULL then this get_user() will return -EFAULT.  It's not
a dereference.  I think Smatch gets confused how this implemented on
arch/m68k/.

153322f7536a18 fs/cifs/smb2ops.c Steve French 2019-03-28  2004  		return -EFAULT;
153322f7536a18 fs/cifs/smb2ops.c Steve French 2019-03-28  2005  
153322f7536a18 fs/cifs/smb2ops.c Steve French 2019-03-28  2006  	/*
153322f7536a18 fs/cifs/smb2ops.c Steve French 2019-03-28  2007  	 * Note that for snapshot queries that servers like Azure expect that
153322f7536a18 fs/cifs/smb2ops.c Steve French 2019-03-28  2008  	 * the first query be minimal size (and just used to get the number/size
153322f7536a18 fs/cifs/smb2ops.c Steve French 2019-03-28  2009  	 * of previous versions) so response size must be specified as EXACTLY
153322f7536a18 fs/cifs/smb2ops.c Steve French 2019-03-28  2010  	 * sizeof(struct snapshot_array) which is 16 when rounded up to multiple
153322f7536a18 fs/cifs/smb2ops.c Steve French 2019-03-28  2011  	 * of eight bytes.
153322f7536a18 fs/cifs/smb2ops.c Steve French 2019-03-28  2012  	 */
153322f7536a18 fs/cifs/smb2ops.c Steve French 2019-03-28  2013  	if (ret_data_len == 0)
153322f7536a18 fs/cifs/smb2ops.c Steve French 2019-03-28  2014  		max_response_size = MIN_SNAPSHOT_ARRAY_SIZE;
153322f7536a18 fs/cifs/smb2ops.c Steve French 2019-03-28  2015  	else
153322f7536a18 fs/cifs/smb2ops.c Steve French 2019-03-28  2016  		max_response_size = CIFSMaxBufSize;
153322f7536a18 fs/cifs/smb2ops.c Steve French 2019-03-28  2017  
834170c85978b0 fs/cifs/smb2ops.c Steve French 2016-09-30  2018  	rc = SMB2_ioctl(xid, tcon, cfile->fid.persistent_fid,
834170c85978b0 fs/cifs/smb2ops.c Steve French 2016-09-30  2019  			cfile->fid.volatile_fid,
834170c85978b0 fs/cifs/smb2ops.c Steve French 2016-09-30  2020  			FSCTL_SRV_ENUMERATE_SNAPSHOTS,
153322f7536a18 fs/cifs/smb2ops.c Steve French 2019-03-28  2021  			NULL, 0 /* no input data */, max_response_size,
834170c85978b0 fs/cifs/smb2ops.c Steve French 2016-09-30  2022  			(char **)&retbuf,
834170c85978b0 fs/cifs/smb2ops.c Steve French 2016-09-30  2023  			&ret_data_len);
834170c85978b0 fs/cifs/smb2ops.c Steve French 2016-09-30  2024  	cifs_dbg(FYI, "enum snaphots ioctl returned %d and ret buflen is %d\n",
834170c85978b0 fs/cifs/smb2ops.c Steve French 2016-09-30  2025  			rc, ret_data_len);
834170c85978b0 fs/cifs/smb2ops.c Steve French 2016-09-30  2026  	if (rc)
834170c85978b0 fs/cifs/smb2ops.c Steve French 2016-09-30  2027  		return rc;
834170c85978b0 fs/cifs/smb2ops.c Steve French 2016-09-30  2028  
834170c85978b0 fs/cifs/smb2ops.c Steve French 2016-09-30 @2029  	if (ret_data_len && (ioc_buf != NULL) && (retbuf != NULL)) {

Anyway, ioc_buf still can't be NULL at this point.

834170c85978b0 fs/cifs/smb2ops.c Steve French 2016-09-30  2030  		/* Fixup buffer */
834170c85978b0 fs/cifs/smb2ops.c Steve French 2016-09-30  2031  		if (copy_from_user(&snapshot_in, ioc_buf,
834170c85978b0 fs/cifs/smb2ops.c Steve French 2016-09-30  2032  		    sizeof(struct smb_snapshot_array))) {
834170c85978b0 fs/cifs/smb2ops.c Steve French 2016-09-30  2033  			rc = -EFAULT;
834170c85978b0 fs/cifs/smb2ops.c Steve French 2016-09-30  2034  			kfree(retbuf);
834170c85978b0 fs/cifs/smb2ops.c Steve French 2016-09-30  2035  			return rc;
834170c85978b0 fs/cifs/smb2ops.c Steve French 2016-09-30  2036  		}
834170c85978b0 fs/cifs/smb2ops.c Steve French 2016-09-30  2037  
e02789a53d7133 fs/cifs/smb2ops.c Steve French 2018-08-09  2038  		/*
e02789a53d7133 fs/cifs/smb2ops.c Steve French 2018-08-09  2039  		 * Check for min size, ie not large enough to fit even one GMT
e02789a53d7133 fs/cifs/smb2ops.c Steve French 2018-08-09  2040  		 * token (snapshot).  On the first ioctl some users may pass in
e02789a53d7133 fs/cifs/smb2ops.c Steve French 2018-08-09  2041  		 * smaller size (or zero) to simply get the size of the array
e02789a53d7133 fs/cifs/smb2ops.c Steve French 2018-08-09  2042  		 * so the user space caller can allocate sufficient memory
e02789a53d7133 fs/cifs/smb2ops.c Steve French 2018-08-09  2043  		 * and retry the ioctl again with larger array size sufficient
e02789a53d7133 fs/cifs/smb2ops.c Steve French 2018-08-09  2044  		 * to hold all of the snapshot GMT tokens on the second try.
e02789a53d7133 fs/cifs/smb2ops.c Steve French 2018-08-09  2045  		 */
e02789a53d7133 fs/cifs/smb2ops.c Steve French 2018-08-09  2046  		if (snapshot_in.snapshot_array_size < GMT_TOKEN_SIZE)
e02789a53d7133 fs/cifs/smb2ops.c Steve French 2018-08-09  2047  			ret_data_len = sizeof(struct smb_snapshot_array);
e02789a53d7133 fs/cifs/smb2ops.c Steve French 2018-08-09  2048  
e02789a53d7133 fs/cifs/smb2ops.c Steve French 2018-08-09  2049  		/*
e02789a53d7133 fs/cifs/smb2ops.c Steve French 2018-08-09  2050  		 * We return struct SRV_SNAPSHOT_ARRAY, followed by
e02789a53d7133 fs/cifs/smb2ops.c Steve French 2018-08-09  2051  		 * the snapshot array (of 50 byte GMT tokens) each
e02789a53d7133 fs/cifs/smb2ops.c Steve French 2018-08-09  2052  		 * representing an available previous version of the data
e02789a53d7133 fs/cifs/smb2ops.c Steve French 2018-08-09  2053  		 */
e02789a53d7133 fs/cifs/smb2ops.c Steve French 2018-08-09  2054  		if (ret_data_len > (snapshot_in.snapshot_array_size +
e02789a53d7133 fs/cifs/smb2ops.c Steve French 2018-08-09  2055  					sizeof(struct smb_snapshot_array)))
e02789a53d7133 fs/cifs/smb2ops.c Steve French 2018-08-09  2056  			ret_data_len = snapshot_in.snapshot_array_size +
e02789a53d7133 fs/cifs/smb2ops.c Steve French 2018-08-09  2057  					sizeof(struct smb_snapshot_array);
834170c85978b0 fs/cifs/smb2ops.c Steve French 2016-09-30  2058  
834170c85978b0 fs/cifs/smb2ops.c Steve French 2016-09-30  2059  		if (copy_to_user(ioc_buf, retbuf, ret_data_len))
834170c85978b0 fs/cifs/smb2ops.c Steve French 2016-09-30  2060  			rc = -EFAULT;
834170c85978b0 fs/cifs/smb2ops.c Steve French 2016-09-30  2061  	}
834170c85978b0 fs/cifs/smb2ops.c Steve French 2016-09-30  2062  
834170c85978b0 fs/cifs/smb2ops.c Steve French 2016-09-30  2063  	kfree(retbuf);
834170c85978b0 fs/cifs/smb2ops.c Steve French 2016-09-30  2064  	return rc;
834170c85978b0 fs/cifs/smb2ops.c Steve French 2016-09-30  2065  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

