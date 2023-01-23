Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27DB677A79
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 13:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjAWMEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 07:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjAWMEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 07:04:21 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8234723871;
        Mon, 23 Jan 2023 04:04:17 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r9so10573493wrw.4;
        Mon, 23 Jan 2023 04:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dc6Iu0o4fP6ivasC7UZeOSkzWU+HqKmeQgzRy86uQ1M=;
        b=O6/IZ8T6juXFBxwlihCeu4uCoPmkh1n/nuFQJdZ3eSMX1cv738HyzZycJsj1SCDhfj
         tTnQqGg5PV9EHiw8P/mXED9EBlVfpktM79yV8rqgCuqmoYVH61pDCuQW5JmbUBLcemCC
         ZVf0hqvt8sZrWq0d6XzWygUXcrCJnVOHdXJ9kvSAL9aZJxq1EsOCR1r/E0VT6jc288VG
         dYm9v2vD/l7wqJ10Pn7D8CqqCAKupkSI01P6MxjiaClBIYYu8URNzhUR/yhb7Erv+6je
         2qbuMqMEnH9Et9NimYfzg2Pl3D5PPaafG1A8Z/VCU3lfVOazcTt9rfF/St1B4FWH85u4
         YxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dc6Iu0o4fP6ivasC7UZeOSkzWU+HqKmeQgzRy86uQ1M=;
        b=hDYbTHkPxGK3DScJRGQf8uqtIOSaj8/QU9dJOgXKehJyY/YpGoWrPRm6bFIFRvkj2x
         tzMd2fl7yTOnO/cD3PiUSIASLMoXVllZDb2AjJuZr+DcgueVgBIXSYVvwhhQoufb2Znr
         7XF9wGjNgqzIkDGdosO7+KtAHMcCE7AuN2+q9gJMonw6E/BbXIyjxq+rTMSws8lCPv+E
         nWlUnJvXMmtCUPe5aKrPxlExU1hcbmVdP8ZE4rjEdDb3XKAdh6cVNZ9UcdyZCac/edEb
         kk3YO5eB8XAWiu/Oqg74mpe//+1gu16Gliwr/SxbZXFcMMK2Wty1J1xRW+nFps1jlZVu
         H+GQ==
X-Gm-Message-State: AFqh2krvDt3jS4VbRtsgUrdjS2oF9j8QKJfuTTE908VfUPnEWlIknqMM
        LoVxosiAJGXzMFdlnXtnOmBLa/JI99s=
X-Google-Smtp-Source: AMrXdXva0tO72U7N+MHJLM3e3EW5ga5Hn9KbpUyoOKMqbwKALgpgNVk3x7EdNBa1FSdW/V9ve8Xsyg==
X-Received: by 2002:a5d:4c4e:0:b0:2bb:4b40:2d1a with SMTP id n14-20020a5d4c4e000000b002bb4b402d1amr21946328wrt.56.1674475455949;
        Mon, 23 Jan 2023 04:04:15 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600003cd00b002be07cbefb2sm22510868wrg.18.2023.01.23.04.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 04:04:15 -0800 (PST)
Date:   Mon, 23 Jan 2023 15:04:12 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Ajay Kaher <akaher@vmware.com>,
        rostedt@goodmis.org, mhiramat@kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        chinglinyu@google.com, namit@vmware.com, srivatsab@vmware.com,
        srivatsa@csail.mit.edu, amakhalov@vmware.com,
        vsirnapalli@vmware.com, tkundu@vmware.com, er.ajay.kaher@gmail.com,
        Ajay Kaher <akaher@vmware.com>
Subject: Re: [PATCH 2/8] eventfs: adding eventfs dir add functions
Message-ID: <Y853vPCsTZXEiPgV@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1674407228-49109-2-git-send-email-akaher@vmware.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ajay,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ajay-Kaher/eventfs-adding-eventfs-dir-add-functions/20230123-010956
patch link:    https://lore.kernel.org/r/1674407228-49109-2-git-send-email-akaher%40vmware.com
patch subject: [PATCH 2/8] eventfs: adding eventfs dir add functions
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20230123/202301231023.0ix6JmVM-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
fs/tracefs/event_inode.c:114 eventfs_add_subsystem_dir() error: dereferencing freed memory 'ef'

vim +/ef +114 fs/tracefs/event_inode.c

db5e58a9349f39 Ajay Kaher 2023-01-22   87  struct eventfs_file *eventfs_add_subsystem_dir(const char *name, struct dentry *parent)
db5e58a9349f39 Ajay Kaher 2023-01-22   88  {
db5e58a9349f39 Ajay Kaher 2023-01-22   89  	struct eventfs_file *ef;
db5e58a9349f39 Ajay Kaher 2023-01-22   90  	struct tracefs_inode *ti_parent;
db5e58a9349f39 Ajay Kaher 2023-01-22   91  	struct eventfs_inode *ei_parent;
db5e58a9349f39 Ajay Kaher 2023-01-22   92  
db5e58a9349f39 Ajay Kaher 2023-01-22   93  	if (!parent)
db5e58a9349f39 Ajay Kaher 2023-01-22   94  		return ERR_PTR(-EINVAL);
db5e58a9349f39 Ajay Kaher 2023-01-22   95  
db5e58a9349f39 Ajay Kaher 2023-01-22   96  	ti_parent = get_tracefs(parent->d_inode);
db5e58a9349f39 Ajay Kaher 2023-01-22   97  	ei_parent = ti_parent->private;
db5e58a9349f39 Ajay Kaher 2023-01-22   98  
db5e58a9349f39 Ajay Kaher 2023-01-22   99  	ef = kzalloc(sizeof(*ef), GFP_KERNEL);
db5e58a9349f39 Ajay Kaher 2023-01-22  100  	if (!ef)
db5e58a9349f39 Ajay Kaher 2023-01-22  101  		return ERR_PTR(-ENOMEM);
db5e58a9349f39 Ajay Kaher 2023-01-22  102  
db5e58a9349f39 Ajay Kaher 2023-01-22  103  	ef->ei = kzalloc(sizeof(*ef->ei), GFP_KERNEL);
db5e58a9349f39 Ajay Kaher 2023-01-22  104  	if (!ef->ei) {
db5e58a9349f39 Ajay Kaher 2023-01-22  105  		kfree(ef);
db5e58a9349f39 Ajay Kaher 2023-01-22  106  		return ERR_PTR(-ENOMEM);
db5e58a9349f39 Ajay Kaher 2023-01-22  107  	}
db5e58a9349f39 Ajay Kaher 2023-01-22  108  
db5e58a9349f39 Ajay Kaher 2023-01-22  109  	INIT_LIST_HEAD(&ef->ei->e_top_files);
db5e58a9349f39 Ajay Kaher 2023-01-22  110  
db5e58a9349f39 Ajay Kaher 2023-01-22  111  	ef->name = kstrdup(name, GFP_KERNEL);
db5e58a9349f39 Ajay Kaher 2023-01-22  112  	if (!ef->name) {
db5e58a9349f39 Ajay Kaher 2023-01-22  113  		kfree(ef);
db5e58a9349f39 Ajay Kaher 2023-01-22 @114  		kfree(ef->ei);

kfree(ef->ei); first to avoid a use after free.

db5e58a9349f39 Ajay Kaher 2023-01-22  115  		return ERR_PTR(-ENOMEM);
db5e58a9349f39 Ajay Kaher 2023-01-22  116  	}
db5e58a9349f39 Ajay Kaher 2023-01-22  117  
db5e58a9349f39 Ajay Kaher 2023-01-22  118  	ef->mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
db5e58a9349f39 Ajay Kaher 2023-01-22  119  	ef->iop = &eventfs_root_dir_inode_operations;
db5e58a9349f39 Ajay Kaher 2023-01-22  120  	ef->fop =  &eventfs_file_operations;
db5e58a9349f39 Ajay Kaher 2023-01-22  121  	ef->dentry = NULL;
db5e58a9349f39 Ajay Kaher 2023-01-22  122  	ef->created = false;
db5e58a9349f39 Ajay Kaher 2023-01-22  123  	ef->d_parent = parent;
db5e58a9349f39 Ajay Kaher 2023-01-22  124  
db5e58a9349f39 Ajay Kaher 2023-01-22  125  	list_add_tail(&ef->list, &ei_parent->e_top_files);
db5e58a9349f39 Ajay Kaher 2023-01-22  126  	return ef;
db5e58a9349f39 Ajay Kaher 2023-01-22  127  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

