Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7686562F6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 14:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbiLZN6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 08:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiLZN6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 08:58:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AA7C25
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 05:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672063048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xNkpB2+u8Eqmau278f4T4WUJLfMelhcgCd97s/yvcas=;
        b=URDFDYzSTYNLdF+m0Wdis6htYB5NE9l++KgOaDCDMUULTCFbCggMSEWgSHlmxaQD0u9uOe
        BKavCwtDuCL5uJsC+i6RrM5t1GyuzLBy/Bi+BHwN67KVd01frrsvvcFt8r8giRf3cQG3Um
        kPyJDFwmnKxPTCiAI5iNz+c1nXo3T4c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-N1_Ltle7OD-TxwLYhWP6PQ-1; Mon, 26 Dec 2022 08:57:23 -0500
X-MC-Unique: N1_Ltle7OD-TxwLYhWP6PQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB2A82A59572;
        Mon, 26 Dec 2022 13:57:22 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B8781140EBF4;
        Mon, 26 Dec 2022 13:57:22 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id B20EF404EA357; Mon, 26 Dec 2022 09:43:57 -0300 (-03)
Date:   Mon, 26 Dec 2022 09:43:57 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     oe-kbuild@lists.linux.dev, Fenghua Yu <fenghua.yu@intel.com>,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] hwmon: coretemp: avoid RDMSR interruptions to isolated
 CPUs
Message-ID: <Y6mXDUZkII5OnuE8@tpad>
References: <Y5sWMEG0xCl9bgEi@tpad>
 <202212170101.tpSDqf7K-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212170101.tpSDqf7K-lkp@intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 01:48:14PM +0300, Dan Carpenter wrote:
> Hi Marcelo,
> 
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Marcelo-Tosatti/hwmon-coretemp-avoid-RDMSR-interruptions-to-isolated-CPUs/20221215-204904
> patch link:    https://lore.kernel.org/r/Y5sWMEG0xCl9bgEi%40tpad
> patch subject: [PATCH] hwmon: coretemp: avoid RDMSR interruptions to isolated CPUs
> config: i386-randconfig-m021
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> 
> smatch warnings:
> drivers/hwmon/coretemp.c:181 show_temp() warn: inconsistent returns '&tdata->update_lock'.
> 
> vim +181 drivers/hwmon/coretemp.c
> 
> 199e0de7f5df31 Durgadoss R     2011-05-20  154  static ssize_t show_temp(struct device *dev,
> 199e0de7f5df31 Durgadoss R     2011-05-20  155  			struct device_attribute *devattr, char *buf)
> 199e0de7f5df31 Durgadoss R     2011-05-20  156  {
> bebe467823c0d8 Rudolf Marek    2007-05-08  157  	u32 eax, edx;
> 199e0de7f5df31 Durgadoss R     2011-05-20  158  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> 199e0de7f5df31 Durgadoss R     2011-05-20  159  	struct platform_data *pdata = dev_get_drvdata(dev);
> 199e0de7f5df31 Durgadoss R     2011-05-20  160  	struct temp_data *tdata = pdata->core_data[attr->index];
> 199e0de7f5df31 Durgadoss R     2011-05-20  161  
> 199e0de7f5df31 Durgadoss R     2011-05-20  162  	mutex_lock(&tdata->update_lock);
> bebe467823c0d8 Rudolf Marek    2007-05-08  163  
> 199e0de7f5df31 Durgadoss R     2011-05-20  164  	/* Check whether the time interval has elapsed */
> 199e0de7f5df31 Durgadoss R     2011-05-20  165  	if (!tdata->valid || time_after(jiffies, tdata->last_updated + HZ)) {
> e78264610cd902 Marcelo Tosatti 2022-12-15  166  		if (!housekeeping_cpu(tdata->cpu, HK_TYPE_MISC))
> e78264610cd902 Marcelo Tosatti 2022-12-15  167  			return -EINVAL;
> 
> mutex_unlock(&tdata->update_lock);
> 
> 199e0de7f5df31 Durgadoss R     2011-05-20  168  		rdmsr_on_cpu(tdata->cpu, tdata->status_reg, &eax, &edx);
> bf6ea084ebb54c Guenter Roeck   2013-11-20  169  		/*
> bf6ea084ebb54c Guenter Roeck   2013-11-20  170  		 * Ignore the valid bit. In all observed cases the register
> bf6ea084ebb54c Guenter Roeck   2013-11-20  171  		 * value is either low or zero if the valid bit is 0.
> bf6ea084ebb54c Guenter Roeck   2013-11-20  172  		 * Return it instead of reporting an error which doesn't
> bf6ea084ebb54c Guenter Roeck   2013-11-20  173  		 * really help at all.
> bf6ea084ebb54c Guenter Roeck   2013-11-20  174  		 */
> bf6ea084ebb54c Guenter Roeck   2013-11-20  175  		tdata->temp = tdata->tjmax - ((eax >> 16) & 0x7f) * 1000;
> 952a11ca32a604 Paul Fertser    2021-09-24  176  		tdata->valid = true;
> 199e0de7f5df31 Durgadoss R     2011-05-20  177  		tdata->last_updated = jiffies;
> bebe467823c0d8 Rudolf Marek    2007-05-08  178  	}
> bebe467823c0d8 Rudolf Marek    2007-05-08  179  
> 199e0de7f5df31 Durgadoss R     2011-05-20  180  	mutex_unlock(&tdata->update_lock);
> bf6ea084ebb54c Guenter Roeck   2013-11-20 @181  	return sprintf(buf, "%d\n", tdata->temp);
> bebe467823c0d8 Rudolf Marek    2007-05-08  182  }
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp

Thanks,

v3 of the patch should not suffer from this issue.

